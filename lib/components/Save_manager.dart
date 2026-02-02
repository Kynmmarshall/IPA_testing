// save_manager.dart
import 'package:shared_preferences/shared_preferences.dart';

class SaveManager {
  static const String _unlockedLevelsKey = 'unlocked_levels';
  //static const String _currentLevelKey = 'current_level';

  // Save unlocked levels
  static Future<void> saveUnlockedLevels(int highestUnlockedLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_unlockedLevelsKey, highestUnlockedLevel);
  }

  // Load unlocked levels
  static Future<int> loadUnlockedLevels() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_unlockedLevelsKey) ?? 1; // Default to level 1 unlocked
  }

  // Save current level progress
  // static Future<void> saveCurrentLevel(int level) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_currentLevelKey, level);
  // }

  // // Load current level progress
  // static Future<int> loadCurrentLevel() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt(_currentLevelKey) ?? 1; // Default to level 1
  // }

}