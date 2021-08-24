import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LawPage extends StatefulWidget {
  @override
  _LawPageState createState() => _LawPageState();
}

class _LawPageState extends State<LawPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        Text("Обещание следопытов", style: headlineStyle(), textAlign: TextAlign.center,),
        Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
        SelectableText("С помощью Божьей\nЯ обещаю быть честным, добрым и верным.\nЯ буду соблюдать законы следопытов.\nЯ буду слугою Бога и другом людей.", style: textStyle(), textAlign: TextAlign.center,),
        Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        Text("Закон следопытов", style: headlineStyle(), textAlign: TextAlign.center,),
        Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
        SelectableText("Начинать день с чтения Библии и молитвы.\nЧестно исполнять свои обязанности.\nЗаботиться о своём теле.\nБыть правдивым.\nБыть вежливым и послушным.\nС благоговением относиться к Богослужению.\nЖить с песней в сердце.\nИсполнять Божьи повеления.", style: textStyle(), textAlign: TextAlign.center)
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