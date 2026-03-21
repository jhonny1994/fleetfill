import 'dart:convert';
import 'dart:io';

void main() {
  final root = Directory.current;
  final source = File('${root.path}/data/locations/wilayas-with-municipalities.json');
  final target = File('${root.path}/supabase/seeds/locations.sql');

  final raw = jsonDecode(source.readAsStringSync()) as List<dynamic>;
  final buffer = StringBuffer()
    ..writeln('-- Generated from data/locations/wilayas-with-municipalities.json')
    ..writeln(
      '-- Regenerate with: dart run tool/locations/generate_supabase_location_seed.dart',
    )
    ..writeln('truncate table public.communes restart identity cascade;')
    ..writeln('truncate table public.wilayas restart identity cascade;')
    ..writeln()
    ..writeln('insert into public.wilayas (id, name, name_ar)')
    ..writeln('values');

  for (var i = 0; i < raw.length; i++) {
    final wilaya = raw[i] as Map<String, dynamic>;
    final suffix = i == raw.length - 1 ? ';' : ',';
    buffer.writeln(
      '  (${wilaya['wilayaCode']}, ${_sqlString(wilaya['nameFr'] as String)}, ${_sqlString(wilaya['nameAr'] as String)})$suffix',
    );
  }

  final communes = <Map<String, dynamic>>[];
  for (final wilaya in raw.cast<Map<String, dynamic>>()) {
    final wilayaCode = wilaya['wilayaCode'] as int;
    for (final commune
        in (wilaya['communes'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      final id = commune['id'];
      if (id == null) {
        continue;
      }
      communes.add({
        'id': id,
        'wilayaCode': wilayaCode,
        'nameFr': commune['nameFr'],
        'nameAr': commune['nameAr'],
      });
    }
  }

  buffer
    ..writeln()
    ..writeln('insert into public.communes (id, wilaya_id, name, name_ar)')
    ..writeln('values');
  for (var i = 0; i < communes.length; i++) {
    final commune = communes[i];
    final suffix = i == communes.length - 1 ? ';' : ',';
    buffer.writeln(
      '  (${commune['id']}, ${commune['wilayaCode']}, ${_sqlString(commune['nameFr'] as String)}, ${_sqlString(commune['nameAr'] as String)})$suffix',
    );
  }

  target
    ..createSync(recursive: true)
    ..writeAsStringSync(buffer.toString());
}

String _sqlString(String value) {
  final escaped = value.replaceAll("'", "''");
  return "'$escaped'";
}
