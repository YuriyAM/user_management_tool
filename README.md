# user_management_tool

This is a trialware version of original **user_management_tool** application.

This version implements trialware licensing model with the secret key generated with Caesar cipher.

By default product key equals to username shifted by 3 digits to the left.  
Example:
- username: **testuser**
- product key: **qbpqrpbo**


## Compatibility

The trialware version supports backward compatibility.

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