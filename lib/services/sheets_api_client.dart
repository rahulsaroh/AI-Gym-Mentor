import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// A lightweight replacement for googleapis Sheets and Drive SDKs.
/// Uses raw HTTP calls to reduce APK size.
class SheetsApiClient {
  final http.Client client;
  static const String _sheetsBaseUrl = 'https://sheets.googleapis.com/v4/spreadsheets';
  static const String _driveBaseUrl = 'https://www.googleapis.com/drive/v3/files';

  SheetsApiClient(this.client);

  /// Search for an existing spreadsheet by name.
  Future<String?> findSpreadsheetId(String name) async {
    final query = "name = '$name' and mimeType = 'application/vnd.google-apps.spreadsheet' and trashed = false";
    final url = Uri.parse('$_driveBaseUrl?q=${Uri.encodeComponent(query)}&spaces=drive&fields=files(id,name)');

    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final files = data['files'] as List?;
        if (files != null && files.isNotEmpty) {
          return files.first['id'] as String?;
        }
      } else {
        debugPrint('SheetsApiClient: findSpreadsheetId failed (${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      debugPrint('SheetsApiClient: Error finding spreadsheet: $e');
    }
    return null;
  }

  /// Create a new spreadsheet with the given title and sheets.
  Future<Map<String, dynamic>?> createSpreadsheet(String title, List<String> sheetTitles) async {
    final url = Uri.parse(_sheetsBaseUrl);
    final body = {
      'properties': {'title': title},
      'sheets': sheetTitles.map((t) => {'properties': {'title': t}}).toList(),
    };

    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint('SheetsApiClient: createSpreadsheet failed (${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      debugPrint('SheetsApiClient: Error creating spreadsheet: $e');
    }
    return null;
  }

  /// Batch update spreadsheet (formatting, freezing rows, etc).
  Future<void> batchUpdate(String spreadsheetId, List<Map<String, dynamic>> requests) async {
    final url = Uri.parse('$_sheetsBaseUrl/$spreadsheetId:batchUpdate');
    final body = {'requests': requests};

    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        debugPrint('SheetsApiClient: batchUpdate failed (${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      debugPrint('SheetsApiClient: Error in batchUpdate: $e');
    }
  }

  /// Append rows to a specific range.
  Future<void> appendValues(String spreadsheetId, String range, List<List<dynamic>> values) async {
    final url = Uri.parse('$_sheetsBaseUrl/$spreadsheetId/values/$range:append?valueInputOption=USER_ENTERED');
    final body = {'values': values};

    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 429) {
          throw Exception('RATE_LIMIT_EXCEEDED');
        }
        debugPrint('SheetsApiClient: appendValues failed (${response.statusCode}): ${response.body}');
        throw Exception('Sheets API Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('SheetsApiClient: Error appending values: $e');
      rethrow;
    }
  }

  /// Upload or update a file on Google Drive.
  Future<void> uploadFile({
    required String name,
    required String mimeType,
    required String content,
    String? fileId,
  }) async {
    final url = fileId == null
        ? Uri.parse('https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart')
        : Uri.parse('https://www.googleapis.com/upload/drive/v3/files/$fileId?uploadType=multipart');

    final boundary = '-------314159265358979323846';
    final delimiter = "\r\n--$boundary\r\n";
    final closeDelimiter = "\r\n--$boundary--";

    final metadata = jsonEncode({
      'name': name,
      'mimeType': mimeType,
    });

    final body = StringBuffer()
      ..write(delimiter)
      ..write('Content-Type: application/json; charset=UTF-8\r\n\r\n')
      ..write(metadata)
      ..write(delimiter)
      ..write('Content-Type: $mimeType\r\n\r\n')
      ..write(content)
      ..write(closeDelimiter);

    try {
      final response = await client.send(
        http.Request(fileId == null ? 'POST' : 'PATCH', url)
          ..headers.addAll({
            'Content-Type': 'multipart/related; boundary=$boundary',
            'Content-Length': body.length.toString(),
          })
          ..body = body.toString(),
      );

      if (response.statusCode != 200) {
        final resBody = await response.stream.bytesToString();
        debugPrint('SheetsApiClient: uploadFile failed (${response.statusCode}): $resBody');
      }
    } catch (e) {
      debugPrint('SheetsApiClient: Error uploading file: $e');
    }
  }

  /// List files matching a query.
  Future<List<dynamic>> listFiles(String query, {String? orderBy}) async {
    var urlStr = '$_driveBaseUrl?q=${Uri.encodeComponent(query)}&spaces=drive&fields=files(id,name,modifiedTime)';
    if (orderBy != null) {
      urlStr += '&orderBy=${Uri.encodeComponent(orderBy)}';
    }
    final url = Uri.parse(urlStr);

    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['files'] as List? ?? [];
      }
    } catch (e) {
      debugPrint('SheetsApiClient: Error listing files: $e');
    }
    return [];
  }

  /// Download file content as String.
  Future<String?> downloadFile(String fileId) async {
    final url = Uri.parse('$_driveBaseUrl/$fileId?alt=media');

    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint('SheetsApiClient: Error downloading file: $e');
    }
    return null;
  }
}
