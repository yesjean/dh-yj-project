# my_first_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 셋팅하기

1. flutter 설치
https://docs.flutter.dev/get-started/install

2. my_first_app 안에 압축해제한 파일 넣기

3. `flutter doctor`로 설치 확인 및, 설치해야될거 추가 설치
    - flutter doctor 명령어는 필요한 도구와 구성 요소가 설치되었는지 확인하고, 부족한 부분을 알려줌
    - Xcode를 설치하고, Xcode Command Line Tools도 설치해야함 App Store에서 Xcode를 설치한 후, 터미널에서 다음   명령을 실행하여 Command Line Tools를 설치 `xcode-select --install`

4. ios에세 테스트 할려면 cocopad 필요
- 설치 `sudo gem install cocoapods`

5. `flutter pub get` 한번 해주고... 플러그인 설치

6. xcode 시뮬레이터 실행

7. `flutter run` 으로 실행

8. 시뮬레이터에서 확인


### flutter

flutter SDK 설치  
https://docs.flutter.dev/get-started/install

환경변수 설정

터미널을 열고, ~/.zshrc 파일을 편집하여 Flutter SDK의 경로를 환경 변수에 추가
```
nano ~/.zshrc
```

다음 줄을 추가

```
export PATH="$PATH:`pwd`/flutter/bin"
```

저장 `ctrl + o`
편집창 나가기 `ctrl + x`

변경 사항을 적용하려면 터미널을 다시 열거나 다음 명령을 실행

```
source ~/.zshrc
```

Flutter 설치 확인:

터미널에서 다음 명령어를 실행하여 Flutter가 제대로 설치되었는지 확인하세요:

```
flutter doctor
```

doctor가 알려주는 필요한거 설치

xcode

Flutter 환경 설정
필수 도구 설치:

flutter doctor 명령어는 필요한 도구와 구성 요소가 설치되었는지 확인하고, 부족한 부분을 알려줍니다. 예를 들어, Xcode, Android Studio, 각 플랫폼의 SDK 등을 설치해야 할 수 있습니다.
명령어 실행 후 나오는 지시에 따라 부족한 부분을 설치하세요.
iOS 개발 환경 설정:

Xcode를 설치하고, Xcode Command Line Tools도 설치해야 합니다. App Store에서 Xcode를 설치한 후, 터미널에서 다음 명령을 실행하여 Command Line Tools를 설치하세요:
```
xcode-select --install
```

Android 개발 환경 설정:

Android Studio를 설치하고, Flutter 플러그인과 Dart 플러그인을 추가하세요. Android SDK와 AVD(Android Virtual Device)를 설정하세요.

프로젝트 생성
`flutter create my_first_app`

실행
`flutter run`

# 구조 설명

Flutter 프로젝트의 기본 구조는 앱 개발을 쉽게 관리하고 유지보수할 수 있도록 여러 디렉터리와 파일로 구성되어 있습니다. 여기에는 Dart 파일, 리소스, 설정 파일 등이 포함됩니다. 아래는 Flutter 프로젝트의 기본 디렉터리와 파일 구조에 대한 설명입니다:

```

my_flutter_project/
│
├── android/
│   └── ... (Android 관련 파일 및 디렉터리)
│
├── ios/
│   └── ... (iOS 관련 파일 및 디렉터리)
│
├── lib/
│   ├── main.dart (애플리케이션 진입점)
│   └── ... (추가적인 Dart 파일)
│
├── test/
│   └── ... (테스트 코드)
│
├── build/
│   └── ... (빌드 파일)
│
├── pubspec.yaml (의존성 및 설정 파일)
│
├── README.md (프로젝트 설명 파일)
│
└── .gitignore (버전 관리에서 제외할 파일 목록)


```

android/:

Android 플랫폼과 관련된 코드와 설정 파일들이 포함되어 있습니다.
build.gradle, AndroidManifest.xml 등 Android 프로젝트의 구성 요소가 있습니다.
ios/:

iOS 플랫폼과 관련된 코드와 설정 파일들이 포함되어 있습니다.
Runner.xcodeproj, Info.plist 등 iOS 프로젝트의 구성 요소가 있습니다.
lib/:

Dart 코드 파일이 포함된 디렉터리입니다.
main.dart: 애플리케이션의 진입점입니다. Flutter 애플리케이션의 실행을 시작하는 파일입니다.
다른 Dart 파일들을 추가하여 애플리케이션의 구조를 구성할 수 있습니다.
test/:

애플리케이션 테스트 코드를 포함하는 디렉터리입니다.
유닛 테스트, 위젯 테스트 등을 작성하여 애플리케이션의 다양한 부분을 검증할 수 있습니다.
build/:

애플리케이션이 빌드될 때 생성되는 파일들이 포함된 디렉터리입니다.
일반적으로 직접 수정하지 않으며, Flutter가 자동으로 관리합니다.
pubspec.yaml:

프로젝트의 메타데이터, 의존성(dependencies), 자산(assets) 등을 정의하는 파일입니다.
패키지와 플러그인을 추가하거나 설정을 변경할 때 이 파일을 수정합니다.
README.md:

프로젝트에 대한 설명을 포함하는 파일입니다.
프로젝트의 목적, 설치 방법, 사용 방법 등을 문서화할 수 있습니다.
.gitignore:

버전 관리에서 제외할 파일 및 디렉터리를 지정하는 파일입니다.
일반적으로 빌드 결과물이나 환경 설정 파일들이 포함됩니다.
