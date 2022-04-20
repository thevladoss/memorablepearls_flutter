import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:memorablepearls_flutter/widgets/buttons.dart';

import 'screens/start/welcome_screen.dart';

void main() {
  runApp(PathfinderApp());
}

class PathfinderApp extends StatefulWidget {
  @override
  _PathfinderAppState createState() => _PathfinderAppState();
}

class _PathfinderAppState extends State<PathfinderApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      home: MainPage(),
    );
  }
}



class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final vk = VKLogin();

  Future<void> initSDK() async {
    await vk.initSdk();
  }

  vkAuth() async {

    final res = await vk.logIn(scope: [
      VKScope.email,
    ]);

    if (res.isValue) {
      final VKLoginResult data = res.asValue.value;
      if (!data.isCanceled) {
        final VKAccessToken accessToken = data.accessToken;
        print('Access token: ${accessToken.token}');

        final profile = await vk.getUserProfile();
        print('Добро пожаловать, ${profile.asValue.value.firstName}! Ваш ID: ${profile.asValue.value.userId}');

        final email = await vk.getUserEmail();
        print('Ваш email: $email');
      }
    } else {
      final errorRes = res.asError;
      print('Ошибка при входе: ${errorRes.error}');
    }

  }

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}