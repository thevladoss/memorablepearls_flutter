import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset("assets/LOGO2.png", height: 150,)
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("«Следопыт»", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
        ),
        Padding(padding: const EdgeInsets.all(2.0)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("v2.0", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300), textAlign: TextAlign.center,)
        ),
        Padding(padding: const EdgeInsets.all(8.0)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Разработчик:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))
        ),
        Padding(padding: const EdgeInsets.all(2.0)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            title: Text('Владислав Осин', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/photos/1.png"),
            ),
            subtitle: Text('Разработка мобильного приложения', style: TextStyle(fontSize: 16)),
          ),
        ),
        Padding(padding: const EdgeInsets.all(4.0)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Также участвовали:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
        ),
        Padding(padding: const EdgeInsets.all(2.0)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            title: Text('Роман Марданян', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/photos/2.png"),
            ),
            subtitle: Text('Разработка PDF-файлов'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            title: Text('Ульяна Галкина', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/photos/3.png"),
            ),
            subtitle: Text('Проверка корректности Памятных Жемчужин'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            title: Text('Лилия Доможилкина', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/photos/4.png"),
            ),
            subtitle: Text('Тестирование приложения'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            title: Text('Евгений Васильев', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/photos/5.png"),
            ),
            subtitle: Text('Тестирование приложения'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            title: Text('Илья Горничар', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/photos/6.png"),
            ),
            subtitle: Text('Тестирование приложения'),
          ),
        ),
      ],
    );
  }
}