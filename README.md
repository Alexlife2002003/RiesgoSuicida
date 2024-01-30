# RiesgoSuicida
Es una aplicación desarrollada en flutter, la cual se apoya con firebase, para realizar un apoyo en la identificación de estudiantes universitarios en riesgo de suicidio.

## Modificaciones necesarias
### flutter_swipable.dart
en el pubsec podemos ver la dependencia flutter_swipable de la cual estamos usando la version `1.2.1`,
para su correcto funcionamiento, en su linea 132, es necesario hacer un cambio 
se debe cambiar `overflow:Overflow.visible` por `clipBehavior: Clip.none`

# Download Link

🔗[You can download here](https://alexlife2002003.github.io/RiesgoSuicida-HTML/)

## 📸 Screenshots

## 📚 Dependencies

| Name                                                                                  | Version       | Description                                                                                                                                |
| ------------------------------------------------------------------------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
|[flutter_dotenv](https://pub.dev/packages?q=flutter_dotenv)| 5.1.0    |Easily configure any flutter application with global variables using a `.env` file.|
|[flutter_phone_direct_caller](https://pub.dev/packages/flutter_phone_direct_caller)|Newest version| plugin to call number directly from app, without going to phone dialer. Permission request is handled by plugin.|
|[cloud_firestore](https://pub.dev/packages/cloud_firestore)|4.8.1| plugin for Cloud Firestore, a cloud-hosted, noSQL database with live synchronization and offline support on Android and iOS.|
|[percent_indicator](https://pub.dev/packages/percent_indicator)|3.4.0|Library that allows you to display progress widgets based on percentage, can be Circular or Linear, you can also customize it to your needs.|
|[linear_progress_bar](https://pub.dev/packages/linear_progress_bar)|1.1.0|Flutter and Dart advanced linear progress indicator like Native Android Progress Bar|
|[flutter_dialogs](https://pub.dev/packages/flutter_dialogs)|3.0.0|A lightweight and platform-aware plugin for showing dialogs and alerts for both Android and iOS devices.|
|[url_launcher](https://pub.dev/packages/url_launcher)|6.0.6| plugin for launching a URL. Supports web, phone, SMS, and email schemes.|
|[permission_handler](https://pub.dev/packages/permission_handler)|Newest version|This plugin provides a cross-platform (iOS, Android) API to request and check permissions.|


### Prerequisites

-   Flutter
-   Android Studio / Xcode

### Setup

1. Clone the repo

```sh
git clone
```

2. Install dependencies

```sh
dart pub get
```

3. Run the app

```sh
flutter run
```
