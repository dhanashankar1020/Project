import 'package:flutter_test/flutter_test.dart';
import 'package:shankar2/features/safe_places/services/safe_places_service.dart';

void main() {
  group('SafePlacesService category filtering', () {
    final service = SafePlacesService.instance;

    test('matches police category aliases', () {
      final places = service.getPlacesByCategory('Police');
      expect(places, isNotEmpty);
      expect(places.every((place) => place.category.toLowerCase().contains('police')), isTrue);
    });

    test('matches fire category aliases', () {
      final places = service.getPlacesByCategory('Fire');
      expect(places, isNotEmpty);
      expect(places.every((place) => place.category.toLowerCase().contains('fire')), isTrue);
    });
  });
}
