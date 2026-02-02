// sound_manager.dart
import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundManager {
  static const String _soundEnabledKey = 'sound_enabled';
  static const String _musicEnabledKey = 'music_enabled';
  
  static bool soundEnabled = true;
  static bool musicEnabled = true;
  
  // Initialize sound settings
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    soundEnabled = prefs.getBool(_soundEnabledKey) ?? true;
    musicEnabled = prefs.getBool(_musicEnabledKey) ?? true;
    
    // Preload common sound effects
    if (soundEnabled) {
      await _preloadSounds();
    }
  }
  
  static Future<void> _preloadSounds() async {
    try {
      await FlameAudio.audioCache.loadAll([
        'jump.wav',
        'collect.wav',
        'hit.wav',
        'checkpoint.wav',
      ]);
    } catch (e) {
      print('Error preloading sounds: $e');
    }
  }
  
  // Sound effects
  // static void playJump() {
  //   if (soundEnabled) FlameAudio.play('jump.wav', volume: 0.7);
  // }
  
  // static void playCollect() {
  //   if (soundEnabled) FlameAudio.play('collect.wav', volume: 0.6);
  // }
  
  // static void playHit() {
  //   if (soundEnabled) FlameAudio.play('appear.wav', volume: 0.8);
  // }
  
  // static void playCheckpoint() {
  //   if (soundEnabled) FlameAudio.play('checkpoint.wav', volume: 0.8);
  // }
  

  
  // Background music
  static void playBGM(String bgmName) {
    if (musicEnabled) {
      FlameAudio.bgm.play(bgmName, volume: 1);
    }
  }
  
  static void stopBGM() {
    FlameAudio.bgm.stop();
  }
  
  static void pauseBGM() {
    FlameAudio.bgm.pause();
  }
  
  static void resumeBGM() {
    if (musicEnabled) {
      FlameAudio.bgm.resume();
    }
  }
  
  // Settings management
  static Future<void> setSoundEnabled(bool enabled) async {
    soundEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundEnabledKey, enabled);
    
    if (!enabled) {
      // Stop all playing sounds
      FlameAudio.audioCache.clearAll();
    }
  }
  
  static Future<void> setMusicEnabled(bool enabled) async {
    musicEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_musicEnabledKey, enabled);
    
    if (!enabled) {
      stopBGM();
    } else {
      // You might want to restart BGM if it was playing
      // This would need to be handled by your game class
    }
  }
  
  static void dispose() {
    stopBGM();
    FlameAudio.audioCache.clearAll();
  }
}