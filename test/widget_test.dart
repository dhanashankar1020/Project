import 'package:flutter_test/flutter_test.dart';
import 'package:shankar2/main.dart';
import 'package:shankar2/features/ai_chat/services/ai_prompt_service.dart';
import 'package:shankar2/features/ai_chat/services/offline_ai_service.dart';
import 'package:shankar2/features/ai_chat/models/user_intent.dart';

void main() {
  group('AI Assistant Tests', () {
    test('AIPromptService detects safe place intents correctly', () {
      final promptService = AIPromptService.instance;
      
      final hospitalIntent = promptService.detectIntent('where is the nearest hospital?');
      expect(hospitalIntent.safePlaceType, SafePlaceType.hospital);
      expect(hospitalIntent.isSafePlace, isTrue);

      final shelterIntent = promptService.detectIntent('find me a storm shelter');
      expect(shelterIntent.safePlaceType, SafePlaceType.shelter);
      expect(shelterIntent.isSafePlace, isTrue);
    });

    test('AIPromptService detects first aid intents correctly', () {
      final promptService = AIPromptService.instance;
      
      final cprIntent = promptService.detectIntent('how to do cpr?');
      expect(cprIntent.firstAidType, FirstAidType.cardiacCPR);
      expect(cprIntent.isFirstAid, isTrue);

      final burnIntent = promptService.detectIntent('treatment for a minor burn');
      expect(burnIntent.firstAidType, FirstAidType.burn);
      expect(burnIntent.isFirstAid, isTrue);
    });

    test('AIPromptService detects emergency intents correctly', () {
      final promptService = AIPromptService.instance;
      
      final earthquakeIntent = promptService.detectIntent('what should i do during an earthquake?');
      expect(earthquakeIntent.emergencyType, EmergencyType.earthquake);
      expect(earthquakeIntent.isEmergency, isTrue);
    });

    test('OfflineAIService generates matching guide responses', () {
      final promptService = AIPromptService.instance;
      final offlineService = OfflineAIService.instance;

      final intent = promptService.detectIntent('earthquake guide');
      final response = offlineService.generateResponse('earthquake guide', intent);
      
      expect(response.text, contains('Offline Disaster Guide: Earthquake'));
      expect(response.text, contains('BEFORE'));
      expect(response.text, contains('DURING'));
      expect(response.text, contains('AFTER'));
    });
  });

  testWidgets('App compiles and mounts successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DisasterHelperApp());
    expect(find.byType(DisasterHelperApp), findsOneWidget);

    // Wait for the splash screen timer to finish and complete navigation
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
