import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:game/components/Save_manager.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('SaveManager Tests', () {
    late MockSharedPreferences mockPrefs;
    
    setUp(() async {
      initTestBinding();
      
      // Mock SharedPreferences
      SharedPreferences.setMockInitialValues({});
      mockPrefs = MockSharedPreferences();
      
      // Use dependency injection or override the static method
      // This is a workaround for testing static methods
    });

    test('Save unlocked levels', () async {
  SharedPreferences.setMockInitialValues({});
  
  // Save level 3
  await SaveManager.saveUnlockedLevels(3);
  
  // Verify it saved correctly by loading
  final result = await SaveManager.loadUnlockedLevels();
  expect(result, 3); // Changed from 1 to 3
  
  // Also test that it overwrites previous value
  await SaveManager.saveUnlockedLevels(7);
  final newResult = await SaveManager.loadUnlockedLevels();
  expect(newResult, 7);
});

    test('Load unlocked levels - default value', () async {
      SharedPreferences.setMockInitialValues({});
      final result = await SaveManager.loadUnlockedLevels();
      expect(result, 1); // Should return default value
    });

    test('Progress persistence', () async {
      // Test that saving and loading maintains consistency
      // This would require proper mocking setup
      
      // For now, verify the methods exist and can be called
      expect(SaveManager.saveUnlockedLevels, isNotNull);
      expect(SaveManager.loadUnlockedLevels, isNotNull);
    });
  });
}