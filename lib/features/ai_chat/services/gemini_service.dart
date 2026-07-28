import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeminiService {
  GeminiService._();

  static final GeminiService instance = GeminiService._();

  static const String _apiKeyPref = 'gemini_api_key';
  static const String _modelName = 'gemini-2.0-flash';

  String? _cachedKey;

  /// Get the stored API key
  Future<String?> getApiKey() async {
    if (_cachedKey != null) return _cachedKey;
    final prefs = await SharedPreferences.getInstance();
    _cachedKey = prefs.getString(_apiKeyPref);
    return _cachedKey;
  }

  /// Save API key locally
  Future<void> saveApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiKeyPref, apiKey);
    _cachedKey = apiKey;
  }

  /// Clear the API key
  Future<void> clearApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_apiKeyPref);
    _cachedKey = null;
  }

  /// Check if API key is configured
  Future<bool> isConfigured() async {
    final key = await getApiKey();
    return key != null && key.isNotEmpty;
  }

  /// Safety settings for emergency content
  static final List<SafetySetting> _safetySettings = [
    SafetySetting(
      HarmCategory.harassment,
      HarmBlockThreshold.high,
    ),
    SafetySetting(
      HarmCategory.hateSpeech,
      HarmBlockThreshold.high,
    ),
    SafetySetting(
      HarmCategory.sexuallyExplicit,
      HarmBlockThreshold.high,
    ),
  ];

  /// System prompt for emergency assistance context
  static const String _systemPrompt = '''
You are SafePlace AI, an intelligent emergency assistant for the Offline Disaster Helper app. 
Your role is to provide accurate, life-saving emergency information.

When responding:
1. Be clear, concise, and calm
2. Prioritize safety above all else
3. Provide step-by-step instructions for emergencies
4. Recommend specific types of safe places when relevant (hospitals, shelters, police stations, fire stations, relief centers)
5. For medical queries, include first aid guidance
6. For natural disasters, provide before/during/after protocols
7. Always remind users to call emergency services (108, 100, 101) for serious emergencies

If you're unsure about something, acknowledge the uncertainty rather than giving potentially dangerous advice.
Keep responses under 500 characters when possible for readability.
''';

  /// Generate a response from Gemini
  Future<String> generateResponse(
    String message, {
    List<Content>? history,
  }) async {
    final apiKey = await getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Gemini API key not configured');
    }

    try {
      final model = GenerativeModel(
        model: _modelName,
        apiKey: apiKey,
        safetySettings: _safetySettings,
        systemInstruction: Content.text(_systemPrompt),
      );

      // Send message directly
      final response = await model.generateContent([
        ...?history,
        Content.text(message),
      ]);
      final text = response.text;

      if (text == null || text.isEmpty) {
        throw Exception('Empty response from Gemini');
      }

      return text;
    } on SocketException {
      throw Exception(
        'No internet connection. Please switch to offline mode.',
      );
    } on HttpException {
      throw Exception('Network error. Please switch to offline mode.');
    } on FormatException {
      throw Exception('Invalid response format from Gemini API.');
    } catch (e) {
      debugPrint('GeminiService error: $e');
      rethrow;
    }
  }
}
