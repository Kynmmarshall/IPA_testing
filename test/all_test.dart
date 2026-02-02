import 'unit/components/player_test.dart' as player_test;
import 'unit/components/enemy_test.dart' as enemies_test;
import 'unit/managers/save_manager_test.dart' as save_manager_test;
import 'unit/utils/collision_test.dart' as collision_test;
import 'integration/level_integration_test.dart' as level_integration_test;
import 'system/game_widget_test.dart' as game_widget_test;
import 'test_setup.dart' as test_setup;

void main() {
  // Setup test environment before running tests
  test_setup.setupTestEnvironment();
  
  print('🚀 Running Fruit Collector Test Suite...\n');
  
  // Run unit tests
  print('📋 UNIT TESTS');
  print('=' * 50);
  player_test.main();
  enemies_test.main();
  save_manager_test.main();
  collision_test.main();
  
  // Run integration tests
  print('\n🔗 INTEGRATION TESTS');
  print('=' * 50);
  level_integration_test.main();
  
  // Run system tests
  print('\n🎮 SYSTEM TESTS');
  print('=' * 50);
  game_widget_test.main();
  
  print('\n✅ All test suites completed!');
}