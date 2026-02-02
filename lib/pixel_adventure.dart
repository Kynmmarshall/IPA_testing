import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:game/components/Save_manager.dart';
import 'package:game/components/Sound_Manager.dart';
import 'package:game/components/jump_button.dart';
import 'package:game/components/player.dart';
import 'package:game/components/level.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Add these variables to track game state
  GameState _currentGameState = GameState.menu;
  
  enum GameState {
    menu,
    playing,
    gameOver,
  }

class PixelAdventure extends FlameGame 
with HasKeyboardHandlerComponents, DragCallbacks , HasCollisionDetection, TapCallbacks{
  @override
  Color backgroundColor() => const Color.fromARGB(255, 34, 32, 53);
  late CameraComponent cam;
  Player player = Player(character: 'Ninja Frog');
  late JoystickComponent joystick;
  bool showControls = true;
  double soundVolume = 1.0;
  bool _isLoading = false;
  bool play = false;
  int lives = 3;
  int Fruits = 0;
  int fruitsCollected = 0 ;
  bool menu_screen = true;

  bool canLoad = false;
  
  int highestUnlockedLevel = 1; // Track the highest unlocked level

  List<String> levelNames = [ 'Menu', 'Credits', 'GameOver' ,'Options', 'Level-01', 'Level-02', 'Level-03', 'Level-04', 'Level-05'];
  int currentLevelIndex = 0;

  bool isBGMPlaying = true;
  String currentBGM = '';

  

  @override
  FutureOr<void> onLoad() async{
    //debugMode = true;  
    // Initialize sound manager
    await SoundManager.init();

    // Load saved progress first
    await _loadGameProgress();
    
    //locate all images into the cache
    print('Starting game load...');
    await images.loadAllImages();

    
    if (showControls){
    print('Adding controls...');
    addjoystick();
    if(play) add(JumpButton());
    }

    print('Starting game load...');
    _loadLevel();

    // Set initial game state and play appropriate BGM
    SoundManager.playBGM('menu_music.mp3');
    _updateGameState();
    print('Game load complete');

    return super.onLoad();
  }

  @override
  void update(double dt) {

    if (showControls && play){
    updatejoystick();
    }
    // Check for game over condition
    if(lives <= 0 && _currentGameState != GameState.gameOver){
      currentLevelIndex = 2; // Game Over level
      menu_screen = true;
      lives = 3;
      play = false;
      _loadLevel(); // This will trigger game state update
    }
    super.update(dt);
  }

  // Save game progress
  Future<void> _saveGameProgress() async {
    await SaveManager.saveUnlockedLevels(highestUnlockedLevel);
    print('Saved progress: Unlocked up to level $highestUnlockedLevel, Current level: $currentLevelIndex');
  }

  //loads saved fame progress
  Future<void> _loadGameProgress() async {
  highestUnlockedLevel = await SaveManager.loadUnlockedLevels();
  print('Loaded progress: Unlocked up to level $highestUnlockedLevel');
}

  // Call this when a level is completed
  void levelCompleted(int completedLevelIndex) {
  // Convert array index to actual level number
  int completedLevelNumber = _getLevelNumberFromIndex(completedLevelIndex);
  
  if (completedLevelNumber > 0) { // Only process actual game levels
    if (completedLevelNumber >= highestUnlockedLevel) {
      highestUnlockedLevel = completedLevelNumber + 1;
      _saveGameProgress();
      print('Level $completedLevelNumber completed! Unlocked level $highestUnlockedLevel');
    }
  }
  }

  int _getLevelNumberFromIndex(int index) {
  if (index >= 4 && index < levelNames.length) { // Level-01 to Level-03
    return index - 3; // Converts index 4->1, 5->2, 6->3
  }
  return -1; // Not a playable level
  }
  
  // In pixel_adventure.dart
  Future<void> clearAllGameData() async {
  print('Clearing all game data...');
  
  // Reset game state variables
  highestUnlockedLevel = 1;
  currentLevelIndex = 0;
  fruitsCollected = 0;
  Fruits = 0;
  lives = 3;
  
  // Clear shared preferences (saved data)
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('unlocked_levels');
  await prefs.remove('current_level');
  await prefs.clear(); // Clears ALL saved data
  
  print('All game data cleared!');
}

  @override
  void onRemove() {
    SoundManager.dispose();
    _disposeAllResources();
    super.onRemove();
  }

  // Update game state based on current conditions
  void _updateGameState() {
    GameState newState;
    
    if (menu_screen) {
      newState = GameState.menu; // fallback
      if(currentLevelIndex == 2){
        newState = GameState.gameOver; //gameover
      }
    } else if (play) {
      newState = GameState.playing;
    } else {
      newState = GameState.menu; // fallback
    }
    
    // Only update BGM if game state actually changed
    if (newState != _currentGameState) {
      _currentGameState = newState;
      _playBackgroundMusic();
    }
  }

  void _disposeAllResources() {
    print('Disposing game resources...');
    
    // Clear all components
    removeWhere((component) => true);
    
    // Clear images cache
    images.clearCache();
    
    
    // Reset game state
    _resetGameState();
  }

  void _resetGameState() {
    play = false;
    currentLevelIndex = 0;
    _isLoading = false;
  }

  void exitGame() {
    print('Exiting game and clearing RAM...');
    
    // Properly dispose before exiting
    _disposeAllResources();
    
    // Exit the app
    SystemNavigator.pop();
  }

  void addjoystick() {
    joystick = JoystickComponent(
      priority : 10000000000,
      knob: SpriteComponent(
        sprite: Sprite(
        images.fromCache('Joystick components/knob.png'),
        ),
        ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('Joystick components/joystick.png')
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 16),
    );
    if(play)add(joystick);
  }
  
  void updatejoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
       player.horizontalMovement = 1;
        break;
      default:
       player.horizontalMovement = 0;
    }
  }
  
  void _playBackgroundMusic() {
    switch (_currentGameState) {
      case GameState.menu:
        SoundManager.playBGM('menu_music.mp3');
        break;
      case GameState.playing:
        SoundManager.playBGM('game_music.mp3');
        break;
      case GameState.gameOver:
        SoundManager.playBGM('game_over_music.mp3');
        break;
    }
    print(' BGM changed to: $_currentGameState');
  }

  void toggleSound(bool enabled) {
    SoundManager.setSoundEnabled(enabled);
  }
  
  void toggleMusic(bool enabled) {
    SoundManager.setMusicEnabled(enabled);
    if (enabled) {
      _playBackgroundMusic();
    }
  }

  void loadNextLevel() {
    if (_isLoading) return; // Prevent multiple simultaneous loads
    _isLoading = true;

    removeWhere((component) => component is Level || component is Player);
    if(currentLevelIndex < levelNames.length - 1){
      currentLevelIndex ++;
    }
    else{
      currentLevelIndex = 4; // your starting level index
    }

    // Save progress when changing levels
    _saveGameProgress();
    
    Future.delayed(const Duration(milliseconds: 200), () {
      _loadLevel();
      _isLoading = false;

      // Update game state but DON'T change BGM if we're still playing
      _updateGameState();
    });
    
  }

  void _loadLevel() {

    Fruits = 0;
    lives = 3;
    fruitsCollected = 0 ;
  Future.delayed(const Duration(seconds: 1,),(){
    print('Loading level: ${levelNames[currentLevelIndex]}');
    Level world = Level(
    player: player,
    levelName: levelNames[currentLevelIndex], 
  );
    cam = CameraComponent.withFixedResolution(
      world: world,
       width: 640, 
       height: 360);
    cam.viewfinder.anchor= Anchor.topLeft;
    if (children.contains(cam)) {
    remove(cam);
  }
    addAll([cam,world]); 

    if (showControls && play){
    print('Adding controls...');
    addjoystick();
    if(play) add(JumpButton());
    }
    // Update game state after level loads
      _updateGameState();
  });
   
  } 


}     