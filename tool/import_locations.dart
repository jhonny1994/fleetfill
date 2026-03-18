import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final env = await _resolveSupabaseEnv();
  final dataset = await _loadDataset();

  final importer = _LocationImporter(
    apiUrl: env.apiUrl,
    serviceRoleKey: env.serviceRoleKey,
    dataset: dataset,
  );

  await importer.run();
}

Future<_SupabaseEnv> _resolveSupabaseEnv() async {
  final apiUrl = Platform.environment['API_URL'];
  final serviceRoleKey = Platform.environment['SERVICE_ROLE_KEY'];

  if (apiUrl != null &&
      apiUrl.isNotEmpty &&
      serviceRoleKey != null &&
      serviceRoleKey.isNotEmpty) {
    return _SupabaseEnv(apiUrl: apiUrl, serviceRoleKey: serviceRoleKey);
  }

  final result = await Process.run('supabase', ['status', '-o', 'env']);
  if (result.exitCode != 0) {
    stderr.writeln(result.stderr);
    throw StateError('Could not resolve local Supabase environment.');
  }

  final values = <String, String>{};
  for (final rawLine in '${result.stdout}'.split('\n')) {
    final line = rawLine.trim();
    if (line.isEmpty || !line.contains('=')) {
      continue;
    }

    final separator = line.indexOf('=');
    final key = line.substring(0, separator);
    final value = line.substring(separator + 1).trim();
    values[key] = value.replaceAll('"', '');
  }

  final resolvedApiUrl = values['API_URL'];
  final resolvedServiceRoleKey = values['SERVICE_ROLE_KEY'];

  if (resolvedApiUrl == null ||
      resolvedApiUrl.isEmpty ||
      resolvedServiceRoleKey == null ||
      resolvedServiceRoleKey.isEmpty) {
    throw StateError(
      'Missing API_URL or SERVICE_ROLE_KEY from Supabase status.',
    );
  }

  return _SupabaseEnv(
    apiUrl: resolvedApiUrl,
    serviceRoleKey: resolvedServiceRoleKey,
  );
}

Future<List<_WilayaInput>> _loadDataset() async {
  final file = File('docs/wilayas-with-municipalities.json');
  final raw = await file.readAsString();
  final decoded = jsonDecode(raw);

  if (decoded is! List) {
    throw StateError(
      'Expected a JSON array in docs/wilayas-with-municipalities.json.',
    );
  }

  return decoded
      .cast<Map<String, dynamic>>()
      .map(_WilayaInput.fromJson)
      .toList(growable: false);
}

class _LocationImporter {
  _LocationImporter({
    required this.apiUrl,
    required this.serviceRoleKey,
    required this.dataset,
  });

  final String apiUrl;
  final String serviceRoleKey;
  final List<_WilayaInput> dataset;

  static const _batchSize = 200;

  Future<void> run() async {
    stdout.writeln('Clearing communes...');
    await _deleteAll(table: 'communes');
    stdout.writeln('Clearing wilayas...');
    await _deleteAll(table: 'wilayas');

    final wilayas = dataset
        .map(
          (item) => {
            'id': item.id,
            'name': item.name,
            'name_ar': item.nameAr,
          },
        )
        .toList(growable: false);

    stdout.writeln('Importing ${wilayas.length} wilayas...');
    await _upsert(table: 'wilayas', rows: wilayas);

    final communes = <Map<String, Object?>>[];
    var skippedCommunes = 0;

    for (final wilaya in dataset) {
      for (final commune in wilaya.communes) {
        if (commune.id == null) {
          skippedCommunes += 1;
          stdout.writeln(
            'Skipping commune without id: wilaya ${wilaya.id} - ${commune.name}',
          );
          continue;
        }

        communes.add({
          'id': commune.id,
          'wilaya_id': wilaya.id,
          'name': commune.name,
          'name_ar': commune.nameAr,
        });
      }
    }

    stdout.writeln('Importing ${communes.length} communes...');
    for (var index = 0; index < communes.length; index += _batchSize) {
      final batch = communes.sublist(
        index,
        index + _batchSize > communes.length
            ? communes.length
            : index + _batchSize,
      );
      await _upsert(table: 'communes', rows: batch);
      stdout.writeln(
        'Imported communes ${index + 1}-${index + batch.length} of ${communes.length}',
      );
    }

    stdout.writeln(
      'Done. Imported ${wilayas.length} wilayas and ${communes.length} communes. '
      'Skipped $skippedCommunes communes without ids.',
    );
  }

  Future<void> _deleteAll({required String table}) async {
    final uri = Uri.parse('$apiUrl/rest/v1/$table?id=gte.0');
    final request = await HttpClient().deleteUrl(uri);
    _applyHeaders(request);
    request.headers.set('Prefer', 'return=minimal');

    final response = await request.close();
    await _ensureSuccess(response, 'delete all rows from $table');
  }

  Future<void> _upsert({
    required String table,
    required List<Map<String, Object?>> rows,
  }) async {
    if (rows.isEmpty) {
      return;
    }

    final uri = Uri.parse('$apiUrl/rest/v1/$table?on_conflict=id');
    final request = await HttpClient().postUrl(uri);
    _applyHeaders(request);
    request.headers.contentType = ContentType(
      'application',
      'json',
      charset: 'utf-8',
    );
    request.headers.set('Prefer', 'resolution=merge-duplicates,return=minimal');
    request.add(utf8.encode(jsonEncode(rows)));

    final response = await request.close();
    await _ensureSuccess(response, 'upsert rows into $table');
  }

  void _applyHeaders(HttpClientRequest request) {
    request.headers.set('apikey', serviceRoleKey);
    request.headers.set('Authorization', 'Bearer $serviceRoleKey');
  }

  Future<void> _ensureSuccess(
    HttpClientResponse response,
    String action,
  ) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      await response.drain<void>();
      return;
    }

    final body = await utf8.decoder.bind(response).join();
    throw HttpException(
      'Failed to $action (${response.statusCode}): $body',
    );
  }
}

class _SupabaseEnv {
  const _SupabaseEnv({required this.apiUrl, required this.serviceRoleKey});

  final String apiUrl;
  final String serviceRoleKey;
}

class _WilayaInput {
  const _WilayaInput({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.communes,
  });

  factory _WilayaInput.fromJson(Map<String, dynamic> json) {
    return _WilayaInput(
      id: json['wilayaCode'] as int,
      name: json['nameFr'] as String,
      nameAr: json['nameAr'] as String,
      communes: (json['communes'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(_CommuneInput.fromJson)
          .toList(growable: false),
    );
  }

  final int id;
  final String name;
  final String nameAr;
  final List<_CommuneInput> communes;
}

class _CommuneInput {
  const _CommuneInput({
    required this.id,
    required this.name,
    required this.nameAr,
  });

  factory _CommuneInput.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];

    return _CommuneInput(
      id: rawId is int ? rawId : null,
      name: json['nameFr'] as String,
      nameAr: json['nameAr'] as String,
    );
  }

  final int? id;
  final String name;
  final String nameAr;
}
