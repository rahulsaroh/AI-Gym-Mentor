import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:io';

void main() {
  test('Gemini AI Generation Smoke Test', () async {
    // Load .env
    await dotenv.load(fileName: '.env');
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    
    print('Testing with API Key: ${apiKey?.substring(0, 8)}...');
    
    expect(apiKey, isNotNull);
    expect(apiKey, isNot('test_key'));

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey!,
    );

    final prompt = 'Generate a 3-exercise workout plan for Chest in JSON format.';
    
    final response = await model.generateContent([Content.text(prompt)]);
    final text = response.text;
    
    print('AI Response: $text');
    
    expect(text, isNotNull);
    expect(text, contains('exercise'));
  }, timeout: const Timeout(Duration(minutes: 1)));
}
