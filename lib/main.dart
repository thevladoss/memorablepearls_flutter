import 'package:flutter/material.dart';

void main() {
  runApp(MPApp());
}

class MPApp extends StatefulWidget {
  @override
  _MPAppState createState() => _MPAppState();
}

class _MPAppState extends State<MPApp> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}