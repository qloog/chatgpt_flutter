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

添加 riverpod 代码生成

```bash
flutter pub add --dev custom_lint
flutter pub add --dev riverpod_lint
flutter pub add riverpod_annotation
flutter pub add --dev riverpod_generator
```

添加 router

```bash
flutter pub add go_router
```


添加 tiktoken 来计算token

```bash
flutter pub add tiktoken
```

添加 collection

```bash
flutter pub add collection
```

添加 record和path_provider，用于录制音频

```bash
flutter pub add record path_provider
```

添加 flutter_svg

```bash
flutter pub add flutter_svg
```


## FAQ

1、编译时报错 `error: compiling for macOS 10.14, but module 'path_provider_foundation' has a minimum deployment target of macOS 10.15:`

原因：`path_provider` 需要 10.15 以上系统版本
解决方法：在 `macos/Runner/Configs/AppInfo.xcconfig` 中添加 `MACOSX_DEPLOYMENT_TARGET = 10.15`

2、编译时，执行 `Running pod install...` 过程中会报错：`Exception: Error running pod install`

原因：`macos/Podfile` 中的macOS版本与 `macos/Runner/Configs/AppInfo.xcconfig` 中的不符
解决方法：修改 `macos/Podfile` 文件中的 `platform :osx, '10.14'` 为 `platform :osx, '10.15'`