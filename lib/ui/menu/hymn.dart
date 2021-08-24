import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HymnPage extends StatefulWidget {

  @override
  _HymnPageState createState() => _HymnPageState();
}

class _HymnPageState extends State<HymnPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Text("Гимн следопытов", style: headlineStyle(), textAlign: TextAlign.center,),
        Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
        SelectableText("Зовут Следопытами нас.\nМы Божии слуги все,\nВерные во всякий час\nВ доброте и чистоте.\nМы весть всему миру несем,\nСвободу и Божью любовь:\nСпаситель, наш Царь Иисус придет\nЗа нами вновь.\n\nИсследовать истину я\nГотов словно Следопыт,\nИ Творцу всего себя\nЯ желаю посвятить.\nГосподь всем нам дарит любовь\nИ всякую благодать,\nЯ верю, что Царь мой, Иисус,\nПридёт опять!", style: textStyle(), textAlign: TextAlign.center,),
      ],
    );
  }

  headlineStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24
    );
  }

  textStyle() {
    return TextStyle(
        fontSize: 18
    );
  }

}