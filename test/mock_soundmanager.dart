// test/mock_sound_manager.dart
class MockSoundManager {
  static bool soundEnabled = true;
  static bool musicEnabled = true;
  static bool initCalled = false;
  static bool disposeCalled = false;
  static String? lastBGM;
  
  static Future<void> init() async {
    initCalled = true;
    // Don't actually load audio files
    return Future.value();
  }
  
  static void playBGM(String bgmName) {
    if (musicEnabled) {
      lastBGM = bgmName;
    }
  }
  
  static void stopBGM() {
    lastBGM = null;
  }
  
  static void pauseBGM() {}
  
  static void resumeBGM() {}
  
  static Future<void> setSoundEnabled(bool enabled) async {
    soundEnabled = enabled;
    return Future.value();
  }
  
  static Future<void> setMusicEnabled(bool enabled) async {
    musicEnabled = enabled;
    return Future.value();
  }
  
  static void dispose() {
    disposeCalled = true;
  }
}

// Override the real SoundManager in tests
void setupSoundManagerForTests() {
  // This is a workaround for testing static classes
  // In production code, consider using dependency injection
}