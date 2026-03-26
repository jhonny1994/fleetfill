import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fleetfill/core/config/app_environment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String _encodeObjectPath(String objectPath) {
  return objectPath
      .split('/')
      .map(Uri.encodeComponent)
      .join('/');
}

Future<void> uploadToProjectStorage({
  required AppEnvironmentConfig environment,
  required SupabaseClient client,
  required String bucketId,
  required String objectPath,
  required String contentType,
  Uint8List? bytes,
  String? filePath,
}) async {
  final accessToken = client.auth.currentSession?.accessToken;
  if (accessToken == null || accessToken.trim().isEmpty) {
    throw const AuthException('authentication_required');
  }

  final payload = bytes ?? await File(filePath!).readAsBytes();
  final uri = Uri.parse(
    '${environment.supabaseUrl}/storage/v1/object/'
    '${Uri.encodeComponent(bucketId)}/${_encodeObjectPath(objectPath)}',
  );

  final httpClient = HttpClient();
  try {
    final request = await httpClient.postUrl(uri);
    request
      ..headers.set(HttpHeaders.authorizationHeader, 'Bearer $accessToken')
      ..headers.set('apikey', environment.supabaseAnonKey)
      ..headers.set('x-upsert', 'false')
      ..headers.contentType = ContentType.parse(contentType)
      ..contentLength = payload.length
      ..add(payload);

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    var message = 'Invalid Storage request';
    String? error;

    if (responseBody.isNotEmpty) {
      try {
        final decoded = jsonDecode(responseBody);
        if (decoded is Map<String, dynamic>) {
          message = decoded['message'] as String? ?? message;
          error = decoded['error'] as String?;
        } else {
          message = responseBody;
        }
      } on FormatException {
        message = responseBody;
      }
    }

    throw StorageException(
      message,
      error: error,
      statusCode: '${response.statusCode}',
    );
  } finally {
    httpClient.close(force: true);
  }
}
