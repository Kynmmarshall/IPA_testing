// test/test_setup.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setupTestEnvironment() {
  // Initialize binding
  TestWidgetsFlutterBinding.ensureInitialized();
  
  // Mock SharedPreferences
  SharedPreferences.setMockInitialValues({
    'unlocked_levels': 1,
  });
  
  // Set up any other global test configurations
}

void mockSoundManager() {
  // Mock sound manager to avoid plugin errors
  // This depends on your actual SoundManager implementation
}