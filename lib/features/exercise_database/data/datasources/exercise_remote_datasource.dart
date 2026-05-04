import 'dart:convert';
import 'package:http/http.dart' as http;

class ExerciseRemoteDatasource {
  final String _baseUrl;
  final Map<String, String> _gifCache = {}; // In-memory cache per session

  ExerciseRemoteDatasource({required String baseUrl}) : _baseUrl = baseUrl;

  Future<String?> fetchGifUrl(String exerciseName) async {
    if (_gifCache.containsKey(exerciseName)) return _gifCache[exerciseName];
    try {
      final encoded = Uri.encodeComponent(exerciseName);
      final response = await http.get(
        Uri.parse('$_baseUrl/api/exercises/name/$encoded'),
      ).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        if (data.isNotEmpty) {
          final gifUrl = data.first['gifUrl'] as String?;
          if (gifUrl != null) {
            _gifCache[exerciseName] = gifUrl;
          }
          return gifUrl;
        }
      }
    } catch (_) {
      // Network failure is non-fatal — return null
    }
    return null;
  }
}
