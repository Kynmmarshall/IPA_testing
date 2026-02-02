import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/painting.dart';
import 'package:game/pixel_adventure.dart';

class Fruitscollected extends TextComponent with HasGameReference<PixelAdventure> {
  
  Fruitscollected(
    {position,
    size,}
  ) : super(
    position: position,
    size: size,
     textRenderer: TextPaint(
      style: const TextStyle(
        fontSize: 24,
        color: Color(0xFFFFFFFF),
        fontFamily: 'PressStart2P', // Retro pixel font
        fontWeight: FontWeight.normal,
        shadows: [
          Shadow(
            color: Color.fromARGB(255, 60, 255, 53), // Orange outline
            offset: Offset(1, 1),
            blurRadius: 0,
          ),
        ],
      ),
    ),
  );
  @override
  FutureOr<void> onLoad() {
    updateScore();
    return super.onLoad();
  }
  @override
  void update(double dt) {
    updateScore();
    super.update(dt);
  }

  void updateScore() {
    if(game.fruitsCollected < game.Fruits){
      text = 'FRUITS : ${game.fruitsCollected} / ${game.Fruits}';
    }
    else{
      text = 'COMPLETE';
    }
    
  }
}
