import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:game/components/player.dart';
import 'package:game/pixel_adventure.dart';

class Touchable extends SpriteAnimationComponent with HasGameReference<PixelAdventure>, TapCallbacks{

  String type = 'Ninja Frog';
  double stepTime = 0.25;
  int amount = 3;
  Vector2 spriteSize = Vector2(48, 48);
  bool isSelected = false; // Track if this character is selected
  String animationType = "";

  Touchable({
    position,
    size,
    this.type = 'Ninja Frog',
  }): super(
      position: position, 
      size: size);
  
  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    _createAnimation();
    // Check if this character is initially selected
    isSelected = (game.player.character == type);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if ( isMounted) {
    _performTask();
  } else {
    print("Touchable not properly attached to game");
  }
    super.onTapDown(event);
  }

  void _createAnimation(){
    if(type == 'Home' || type == 'Exit'){
      spriteSize = Vector2(48, 48);
    }
    else if(type == 'Mask Dude' || type == 'Ninja Frog' || type == 'Virtual Guy' || type == 'Pink Man'){
      spriteSize = Vector2(48, 48);
      stepTime = 0.05;
      amount = 11;
    }
    else if(type.startsWith('Level-')){
      spriteSize = Vector2(48, 48);
      stepTime = 1;
      amount = 1;
    }
    else{
      spriteSize = Vector2(92, 32);
      stepTime = 0.2;
    }
    

    animationType = isSelected ? '$type run' : type;
    if(type.startsWith('Level-')){
       final levelNum = int.tryParse(type.substring(7));
    final isUnlocked = levelNum != null && levelNum <= game.highestUnlockedLevel;
    
    animationType = isUnlocked ? type : 'Level_locked';
    // Make sure you have locked version sprites
    }
    animation = SpriteAnimation.fromFrameData( 
      game.images.fromCache('Terrain/Touchables/$animationType.png'), 
      SpriteAnimationData.sequenced(
        amount: amount, 
        stepTime: stepTime, 
        textureSize: spriteSize,
      ),
    );
  }

  @override
  void update(double dt) {
    // Check if selection status changed
    bool wasSelected = isSelected;
    isSelected = (game.player.character == type);
    
    // Only update animation if selection status actually changed
    if (wasSelected != isSelected) {
      _updateAnimation();
    }
    
    super.update(dt);
  }

  void _updateAnimation() {
    final animationType = isSelected ? "$type run" : type;
    
    animation = SpriteAnimation.fromFrameData( 
      game.images.fromCache('Terrain/Touchables/$animationType.png'), 
      SpriteAnimationData.sequenced(
        amount: amount, 
        stepTime: stepTime, 
        textureSize: spriteSize,
      ),
    );
  }

  void _startGame() {
    if (game.play) return;
    game.play = true;
    game.menu_screen = false;
    game.currentLevelIndex = game.highestUnlockedLevel + 2; //convert actual level to array index
    game.loadNextLevel();
    print("Play button tapped - starting game");
  }

  void _performTask(){
    switch(type){
      case 'Play':
        _startGame();
        break;
      case 'Exit' || 'Exits':
        game.exitGame();
        break;
      case 'Home':
        game.menu_screen = true;
        game.play = false;
        game.lives = 3;
        game.currentLevelIndex = -1;
        game.loadNextLevel();
        break;
      case 'Credits':
        game.menu_screen = true;
        game.play = false;
        game.currentLevelIndex = 0;
        game.loadNextLevel();
        break;
      case 'Options':
        game.menu_screen = true;
        game.play = false;
        game.currentLevelIndex = 2;
        game.loadNextLevel();
        break; // Added missing break
      case 'Mask Dude':
      case 'Pink Man':
      case 'Ninja Frog':
      case 'Virtual Guy':
        // Update all character buttons to reflect new selection
        _updateAllCharacterButtons();
        game.player.character = type;
        if(game.canLoad){
        game.player.loadAllAnimations();}
        break;
      case 'Level-01':
      case 'Level-02':
      case 'Level-03':
      case 'Level-04':
      case 'Level-05':
      final levelNum = int.tryParse(type.substring(7));
      if(levelNum! <= game.highestUnlockedLevel){
        game.menu_screen = false;
        game.play = true;
        game.lives = 3;
        // Convert level number to array index
        game.currentLevelIndex = levelNum +2;
        game.loadNextLevel();}
      else {
        print('Level $levelNum is locked!');
        // You can show a locked message or visual feedback here
       }
      break;
      case 'Reset':
          _resetGameProgress();
      break;

      default:
    }
  }

  void _resetGameProgress() async {
  await game.clearAllGameData();
  game.menu_screen = true;
  game.play = false;
  game.currentLevelIndex = 2;
  game.loadNextLevel();
  print('Game progress reset to default');
  // You can show a confirmation message to the player
}

  void _updateAllCharacterButtons() {
    // Find all character buttons and update their animations
    final characterTypes = ['Mask Dude', 'Pink Man', 'Ninja Frog', 'Virtual Guy'];
    
    for (final component in game.children) {
      if (component is Touchable && characterTypes.contains(component.type)) {
        component.isSelected = (component.type == type);
        component._updateAnimation();
      }
    }
  }
  
}