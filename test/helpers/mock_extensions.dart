import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/rendering.dart';

class MockGame extends Mock implements Game {
  @override
  Future<void> add(Component component) async {
    return super.noSuchMethod(Invocation.method(#add, [component]));
  }
}
class MockComponent extends Mock implements Component {}

extension MockGameExtensions on MockGame {
  void mockAddComponent(Component component) {
    when(add(component)).thenAnswer((_) async {
      await component.onLoad();
      return Future.value();
    });
  }
}

extension MockComponentExtensions on MockComponent {
  void mockLoad() {
    when(onLoad()).thenReturn(Future.value());
  }
  
  void mockUpdate(double dt) {
    when(update(dt)).thenReturn(null);
  }
  
  void mockRender(Canvas canvas) {
    when(render(canvas)).thenReturn(null);
  }
}