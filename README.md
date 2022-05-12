# user_management_tool

**user_management_tool** is a Flutter-based application designed for user management.

## Platform restrictions

**user_management_tool** uses following Flutter packages

- [mongo_dart 0.7.4+1](https://pub.dev/packages/mongo_dart)
- [easy_sidemenu 0.2.1](https://pub.dev/packages/easy_sidemenu)
- [flutter_dotenv 5.0.2](https://pub.dev/packages/flutter_dotenv)
- [flutter_markdown 0.6.10](https://pub.dev/packages/flutter_markdown)

Therefore application can be run on following platforms:

- `ANDROID`
- `IOS`
- `LINUX`
- `MACOS`
- `WINDOWS`

## How to run

1. Create MongoDB database instance with
```
docker-compose up -d
```
2. Build application for your platform with 
```
flutter run -d <PLATFORM>
```