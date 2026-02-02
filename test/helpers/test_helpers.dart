import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/components/collision_block.dart';
import 'package:game/components/player.dart';
import 'package:game/pixel_adventure.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock classes
class MockImages extends Mock implements Images {}
class MockSharedPreferences extends Mock implements SharedPreferences {
  final Map<String, dynamic> _storage = {};

  @override
  Future<bool> setInt(String key, int value) {
    _storage[key] = value;
    return Future.value(true);
  }

  @override
  int? getInt(String key) {
    return _storage[key] as int?;
  }

  @override
  Future<bool> setBool(String key, bool value) {
    _storage[key] = value;
    return Future.value(true);
  }

  @override
  bool? getBool(String key) {
    return _storage[key] as bool?;
  }
}

class TestPixelAdventure extends PixelAdventure {
  @override
  Future<void> onLoad() async {
    // Skip actual initialization to avoid audio errors
    return Future.value();
  }
}
// Test utilities
class TestGame extends FlameGame {
  final List<Component> addedComponents = [];
  // Make it compatible with PixelAdventure requirements
  int lives = 3;
  int Fruits = 0;
  int fruitsCollected = 0;
  bool menu_screen = true;
  bool play = false;
  bool canLoad = false;
  Player player = Player(character: 'Ninja Frog');
  List<String> levelNames = [];
  int currentLevelIndex = 0;
  int highestUnlockedLevel = 1;
  
  @override
  Future<void> onLoad() async {
    return Future.value();
  }

   @override
  Future<void> add(Component component) async {
    addedComponents.add(component);
    
    // Properly set game reference
    if (component is HasGameReference<TestGame>) {
      component.game = this;
    }
    
    // Attach to parent if it has parent reference
    component.parent = this;
    
    // Try to load without requiring images
    try {
      await component.onLoad();
    } catch (e) {
      if (e.toString().contains('Image') || 
          e.toString().contains('Sprite') ||
          e.toString().contains('assets')) {
        // Expected in tests
        print('Image loading skipped in test: ${e.toString()}');
      } else {
        rethrow;
      }
    }
    
    return Future.value();
  }
  
  void reset() {
    addedComponents.clear();
  }
}

Future<ui.Image> createTestImage({
  int width = 100,
  int height = 100,
  Color color = const Color(0xFFFF0000),
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()..color = color;
  
  canvas.drawRect(Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()), paint);
  final picture = recorder.endRecording();
  return picture.toImage(width, height);
}

Future<void> pumpGame(WidgetTester tester, FlameGame game) async {
  await tester.pumpWidget(
    MaterialApp(
      home: GameWidget(game: game),
    ),
  );
  await tester.pumpAndSettle();
}

// Mock flame audio
class MockFlameAudio extends Mock {
  static Future<void> play(String sound, {double volume = 1.0}) async {}
  static Future<void> loadAll(List<String> sounds) async {}
}

// Test collision block
CollisionBlock createTestCollisionBlock({
  Vector2? position,
  Vector2? size,
  bool isPlatform = false,
}) {
  return CollisionBlock(
    position: position ?? Vector2(0, 0),
    size: size ?? Vector2(100, 100),
    isPlatform: isPlatform,
  );
}

// Test player
Player createTestPlayer({
  Vector2? position,
  String character = 'Ninja Frog',
}) {
  return Player(
    position: position ?? Vector2(0, 0),
    character: character,
  );
}

// Wait for component to load
Future<void> waitForComponentLoad(Component component) async {
  await component.onLoad();
  await Future.delayed(const Duration(milliseconds: 100));
}

Future<void> attachComponentToTestGame(Component component) async {
  final testGame = TestGame();
  await testGame.onLoad();
  await testGame.add(component);
}

// Initialize binding for tests
void initTestBinding() {
  TestWidgetsFlutterBinding.ensureInitialized();
}

class TestSoundManager {
  static bool soundEnabled = true;
  static bool musicEnabled = true;
  
  static Future<void> init() async {
    // Don't load actual audio in tests
    return Future.value();
  }
  
  static void playBGM(String bgmName) {
    // No-op in tests
  }
  
  static void stopBGM() {}
  static void pauseBGM() {}
  static void resumeBGM() {}
  static Future<void> setSoundEnabled(bool enabled) async {}
  static Future<void> setMusicEnabled(bool enabled) async {}
  static void dispose() {}
}