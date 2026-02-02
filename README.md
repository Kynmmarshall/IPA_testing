# **Fruit Collector - 2D Platformer Game**

<div align="center">

![Flame Engine](https://img.shields.io/badge/Engine-Flame-red)
![Flutter](https://img.shields.io/badge/Framework-Flutter-blue)
![Platform](https://img.shields.io/badge/Platform-Mobile-green)
![License](https://img.shields.io/badge/License-Educational-yellow)

**A classic 2D platformer game built with Flutter and Flame engine**  
*Featuring smooth controls, engaging gameplay, and multiple levels to explore*

</div>

---

## **📋 Project Information**

| **Category** | **Details** |
|--------------|-------------|
| **Project Title** | Fruit Collector 2D Platformer |
| **Developer** | Kamdeu Yamdjeuson Neil Marshall |
| **Student Email** | kynmmarshall@gmail.com |
| **Course** | CS 3410 - Mobile Application Development |
| **Institution** | The ICT University |
| **Project Type** | Educational Game Development Project |

---

## **🎮 Game Overview**

Fruit Collector is a feature-rich 2D platformer that combines classic gaming mechanics with modern mobile development technologies. The game offers an engaging experience with progressive difficulty, multiple characters, and polished gameplay mechanics.

### **🎯 Core Features**
- ✅ **Smooth Platforming Mechanics** - Run, jump, and navigate through challenging levels
- ✅ **Multiple Playable Characters** - 4 unique characters with distinct animations
- ✅ **Progressive Level System** - 5+ levels with increasing difficulty
- ✅ **Dual Control Schemes** - Virtual joystick + buttons or keyboard support
- ✅ **Persistent Save System** - Progress saved between sessions using SharedPreferences
- ✅ **Collectible System** - Gather fruits and track your collection
- ✅ **Life System** - Three lives per level with checkpoint respawning
- ✅ **Polished Visuals** - Smooth animations and vibrant pixel art
- ✅ **Complete Audio System** - Background music and sound effects
- ✅ **Offline Play** - Fully functional without internet connection

---

## **🕹️ Gameplay Mechanics**

### **Objective**
Navigate through platform-filled levels while:
- Avoiding enemies and obstacles (saws, traps)
- Collecting fruits to increase your score  
- Reaching the checkpoint flag to complete levels
- Unlocking subsequent levels by completing previous ones

### **Character Selection**
| Character |
|-----------|
| Ninja Frog| 
| Mask Dude | 
| Pink Man  |
| Virtual Guy|

### **Level Progression**
```
Level-01 (Forest) → Level-02 (Castle) → Level-03 (Cave) → Level-04 (Factory) → Level-05 (Final)
```

---

## **🎛️ Controls**

### **📱 Touch Controls**
| Control | Location | Action |
|---------|----------|--------|
| Virtual Joystick | Left side | Move character left/right |
| Jump Button | Right side | Jump action |
| Menu Items | Tap anywhere | Navigate UI |

### **⌨️ Keyboard Controls**
| Key | Action |
|-----|--------|
| **Space** | Jump |

---

## **🛠️ Technical Architecture**

### **Tech Stack**
| Component | Technology |
|-----------|------------|
| **Game Engine** | Flame Game Engine 1.0+ |
| **Framework** | Flutter 3.0+ / Dart 2.17+ |
| **Architecture** | Component-based ECS Pattern |
| **State Management** | Custom Game State Handling |
| **Collision System** | Pixel-perfect AABB Detection |
| **Audio Management** | Flame Audio with SharedPreferences |
| **Storage** | SharedPreferences (Platform Feature) |
| **Testing** | Flutter Test with ~80% Coverage |

### **Component Structure**
```
lib/
├── components/
│   ├── player.dart          # Player character with physics
│   ├── enemies.dart         # Enemy AI and behavior
│   ├── level.dart           # Level loading and management
│   ├── collision_block.dart # Collision system
│   ├── fruit.dart          # Collectible items
│   ├── checkpoint.dart     # Level completion
│   └── ... (15+ components)
├── pixel_adventure.dart    # Main game class
└── main.dart              # App entry point
```

### **Platform Feature: Data Persistence**
The game implements **SharedPreferences** for:
- ✅ Saving unlocked levels between sessions
- ✅ Storing player preferences (sound/music settings)
- ✅ Maintaining character selection
- ✅ Cross-session progress persistence

```dart
// Example: Saving game progress
await SaveManager.saveUnlockedLevels(highestUnlockedLevel);
final progress = await SaveManager.loadUnlockedLevels();
```

---

## **🚀 Installation & Setup**

### **Prerequisites**
- Flutter SDK 3.0+ (with Dart 2.17+)
- Android Studio / VS Code with Flutter extension
- Git for version control

### **Step-by-Step Setup**

1. **Clone Repository**
   ```bash
   git clone https://github.com/yourusername/pixel-adventure.git
   cd pixel-adventure
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run on Device/Emulator**
   ```bash
   # For connected device
   flutter run
   
   # For specific device
   flutter run -d <device_id>
   ```

4. **Build Release Version**
   ```bash
   # Android APK
   flutter build apk --release
   
   # iOS (macOS only)
   flutter build ios --release
   ```

### **Testing**
```bash
# Run all tests
flutter test
```

---

## **📊 Performance Optimizations**

| Optimization | Implementation |
|--------------|---------------|
| **Collision Detection** | Efficient AABB algorithms |
| **Sprite Animation** | Preloaded sprite sheets |
| **Memory Management** | Automatic resource cleanup |
| **Frame-Rate Physics** | Delta-time calculations |
| **Asset Loading** | Asynchronous loading with caching |
| **State Updates** | Optimized update cycles |

---

### **Test Structure**
```
test/
├── unit/
│   ├── components/      # Component tests
│   ├── managers/        # Manager tests
│   └── utils/          # Utility tests
├── integration/         # Integration tests
└── system/             # System/UI tests
```

---

## **📱 Platform Support**

| Platform | Status | Notes |
|----------|--------|-------|
| **Android** | ✅ Fully Supported | API 21+ |

---

## **📄 Documentation**

### **Code Documentation**
- Comprehensive DartDoc comments
- Architecture diagrams in `/docs/`
- API reference generated with `dartdoc`

### **User Documentation**
- In-game tutorial (Planned)
- Control scheme display
- Level hints and tips

---

## **🤝 Contributing**

We welcome contributions! Please follow these steps:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** changes (`git commit -m 'Add AmazingFeature'`)
4. **Push** to branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### **Contribution Guidelines**
- Follow Dart/Flutter style guide
- Write tests for new features
- Update documentation as needed
- Ensure backward compatibility

---

## **📧 Contact & Support**

| Contact Method | Details |
|----------------|---------|
| **Developer** | Kamdeu Yamdjeuson Neil Marshall |
| **Email** | kynmmarshall@gmail.com |
| **Course** | CS 3410 - Mobile Application Development |
| **Institution** | The ICT University |
| **Project Duration** | Academic Year 2025-2026 |

### **Issue Reporting**
Found a bug or have a feature request?
1. Check existing issues
2. Create new issue with:
   - Detailed description
   - Steps to reproduce
   - Screenshots/videos
   - Device/OS information

---

## **📜 License & Acknowledgments**

### **License**
```
This project is developed for educational purposes as part of 
CS 3410 Mobile Application Development course at The ICT University.

All game assets (sprites, sounds) are used under educational fair use.
Code is proprietary to the developer for academic assessment.
```

### **Third-Party Credits**
| Resource | Purpose | License |
|----------|---------|---------|
| **Flame Engine** | Game framework | MIT License |
| **Pixel Art Assets** | Game sprites | Educational Use |
| **Sound Effects** | Audio feedback | Educational Use |
| **Flutter** | UI Framework | BSD License |

### **Special Thanks**
- **Flame Engine Community** for excellent documentation
- **CS 3410 Instructor** for guidance and support
- **The ICT University** for academic resources

---

<div align="center">

## **🎮 Built with ❤️ using Flutter & Flame Engine**

**"Fruit Collector" - A CS 3410 Mobile Application Development Project**  
*© 2024 Kamdeu Yamdjeuson Neil Marshall | The ICT University*

</div>