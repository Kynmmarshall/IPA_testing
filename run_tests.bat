@echo off
echo Running Fruit Collector Tests...

echo.
echo === UNIT TESTS ===
flutter test test/unit/

echo.
echo === INTEGRATION TESTS ===
flutter test test/integration/

echo.
echo === SYSTEM TESTS ===
flutter test test/system/

echo.
echo === ALL TESTS ===
flutter test test/all_tests.dart

echo.
echo ✅ Testing complete!
pause