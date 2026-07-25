import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/system_prompt.dart';

class GeminiService {
  GeminiService._();

  static final GeminiService instance = GeminiService._();

  static const String _apiKeyPrefsKey = 'gemini_api_key';

  /// Save API Key in SharedPreferences
  Future<void> saveApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiKeyPrefsKey, key.trim());
  }

  /// Clear saved API Key
  Future<void> clearApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_apiKeyPrefsKey);
  }

  /// Get API Key from SharedPreferences or Environment
  Future<String?> getApiKey() async {
    // 1. Check SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final savedKey = prefs.getString(_apiKeyPrefsKey);
    if (savedKey != null && savedKey.trim().isNotEmpty) {
      return savedKey.trim();
    }

    // 2. Check Platform Environment
    try {
      final envKey = Platform.environment['GEMINI_API_KEY'];
      if (envKey != null && envKey.trim().isNotEmpty) {
        return envKey.trim();
      }
    } catch (_) {}

    // 3. Check Dart Define
    const defineKey = String.fromEnvironment('GEMINI_API_KEY');
    if (defineKey.isNotEmpty) {
      return defineKey;
    }

    return null;
  }

  /// Generate response using Gemini API
  Future<String> generateResponse(
    String prompt, {
    List<Content>? history,
  }) async {
    final apiKey = await getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception(
        "Gemini API Key is not configured. Please set GEMINI_API_KEY in your environment or app settings.",
      );
    }

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(safePlaceSystemPrompt),
    );

    final List<Content> contents = [];

    // Add conversation history if present
    if (history != null) {
      contents.addAll(history);
    }

    // Add the current user prompt
    contents.add(Content.text(prompt));

    final response = await model.generateContent(contents);
    final responseText = response.text;

    if (responseText == null || responseText.isEmpty) {
      throw Exception("Received empty response from Gemini API.");
    }

    return responseText;
  }
}
