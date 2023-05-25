# chatgpt

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Step

生成代码:

```bash
# --delete-conflicting-outputs 可选，会在生成代码冲突的时候，删除原来的代码，重新生成
flutter pub run build_runner build --delete-conflicting-outputs
```

> 生成的代码基本是以 `.g.dart` 结尾的

安装 freezed

```bash
flutter pub add freezed_annotation
flutter pub add --dev build_runner
flutter pub add --dev freezed
# if using freezed to generate fromJson/toJson, also add:
flutter pub add json_annotation
flutter pub add --dev json_serializable
```

安装 SQLite 库

```bash
flutter pub add floor
flutter pub add --dev floor_generator
```

> floor 和 freezed 不能够兼容