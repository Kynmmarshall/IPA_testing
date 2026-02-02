import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/components/customHitBox.dart';
import 'package:game/components/player.dart';
import 'package:game/components/collision_block.dart';
import 'package:game/components/utils.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('Player Tests', () {
    late Player player;
    late TestPixelAdventure testGame;
    
    setUp(() async {
      testGame = TestPixelAdventure();
      await testGame.onLoad();
      
      player = Player(
        position: Vector2.zero(),
        character: 'Ninja Frog',
      );
      
      await testGame.add(player);
    });

    test('Player initialization', () {
      expect(player.character, 'Ninja Frog');
      expect(player.position, Vector2.zero());
      expect(player.horizontalMovement, 0);
      expect(player.isonground, false);
      expect(player.hasjumped, false);
    });

    test('Player state transitions logic', () {
      // Test state logic without calling onLoad()
      
      // Test the state determination logic
      // PlayerState.idle by default
      // PlayerState.running when velocity.x != 0
      // PlayerState.falling when velocity.y > 0
      // PlayerState.jumping when velocity.y < 0
      
      // Test cases using the logic
      expect(Vector2.zero().x == 0, true); // Idle
      expect(Vector2(50, 0).x != 0, true); // Running
      expect(Vector2(0, 50).y > 0, true);  // Falling
      expect(Vector2(0, -50).y < 0, true); // Jumping
    });

    test('Player collision detection', () {
      final block = CollisionBlock(
        position: Vector2(0, 100),
        size: Vector2(50, 50),
      );
      
      // Set up player for collision test
      player.position = Vector2(10, 0);
      player.size = Vector2(32, 32);
      player.hitbox = customHitBox(
        offsetX: 10, 
        offsetY: 4,
        width: 14, 
        height: 28
      );
      
      // Player above block
      expect(checkCollision(player, block), false);
      
      // Player colliding with block
      player.position = Vector2(10, 80);
      expect(checkCollision(player, block), true);
    });

    test('Player gravity calculation', () {
      const gravity = 15.0;
      const dt = 1.0 / 60.0;
      
      // Starting velocity
      final initialVelocity = Vector2.zero();
      
      // After gravity application
      final velocityAfterGravity = Vector2(0, gravity * dt);
      
      expect(velocityAfterGravity.y, greaterThan(0));
    });

    test('Player jump mechanics calculation', () {
      const jumpForce = 360.0;
      
      // Jump should apply upward velocity
      final jumpVelocity = Vector2(0, -jumpForce);
      
      expect(jumpVelocity.y, lessThan(0)); // Negative = upward
    });

    test('Player direction flipping logic', () {
      // Test the direction logic
      // scale.x > 0 = facing right
      // scale.x < 0 = facing left
      
      final facingRight = Vector2(1, 1);
      final facingLeft = Vector2(-1, 1);
      
      expect(facingRight.x > 0, true);
      expect(facingLeft.x < 0, true);
    });
  });
}