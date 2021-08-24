
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memorablepearls_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailTrainingPage extends StatefulWidget {
  final data;
  final int level;
  final theme;

  const DetailTrainingPage(this.data, this.level, this.theme);

  @override
  _DetailTrainingPageState createState() => _DetailTrainingPageState();
}

class _DetailTrainingPageState extends State<DetailTrainingPage> {
  int step = 0;
  List progress = [];
  String translate;

  Future<void> readJson() async {
    var pref = await SharedPreferences.getInstance();
    final String trans = pref.getString("translate");
    setState(() {
      translate = trans;
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (translate != null) {
      Widget body;
      String title;

      if (step < 12) {
        title = widget.data[step]["verse"]["link_small_"+translate];
        body = VerseTrainingPage(widget.data[step]["verse"], widget.level, translate, callbackNext, widget.theme);
      } else {
        body = FinalTrainingPage(progress, widget.level, callbackRepeat);
        title = "Завершение";
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close),
              tooltip: 'Завершить тренировку',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => new CupertinoAlertDialog(
                    title: new Text("Завершить тренировку?"),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: new Text("Нет"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        isDefaultAction: false,
                        child: new Text("Да"),
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                );
              }
          ),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          centerTitle: true,
        ),
        body: body,
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close),
              tooltip: 'Завершить тренировку',
              onPressed: () {
              }
          ),
          title: Text("Загрузка...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.close),
                tooltip: 'Завершить тренировку',
                onPressed: () {
                }
            )
          ],
        ),
        body: Container(),
      );
    }
  }

  callbackNext(int attempts) {
    setState(() {
      progress.add(attempts);
      step += 1;
    });
  }

  callbackRepeat() {
    setState(() {
      progress = [];
      step = 0;
    });
  }
}



class VerseTrainingPage extends StatefulWidget {
  final verse;
  final theme;
  final int level;
  final String translate;
  final Function callbackNext;

  const VerseTrainingPage(this.verse, this.level, this.translate, this.callbackNext, this.theme);

  @override
  _VerseTrainingPageState createState() => _VerseTrainingPageState();
}

class _VerseTrainingPageState extends State<VerseTrainingPage> {
  List alphabet = [
    "А", "Б", "В", "Г", "Д", "Е",
    "Ё", "Ж", "З", "И", "Й", "К",
    "Л", "М", "Н", "О", "П", "Р",
    "С", "Т", "У", "Ф", "Х", "Ц",
    "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь",
    "Э", "Ю", "Я", "а", "б", "в",
    "г", "д", "е", "ё", "ж", "з",
    "и", "й", "к", "л", "м", "н",
    "о", "п", "р", "с", "т", "у",
    "ф", "х", "ц", "ч", "ш", "щ",
    "ъ", "ы", "ь", "э", "ю", "я",
  ];
  List<String> replaces = [];
  String verse = "";
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();
  final textController4 = TextEditingController();
  final textController5 = TextEditingController();
  final textController6 = TextEditingController();
  final textController7 = TextEditingController();

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textController4.dispose();
    textController5.dispose();
    textController6.dispose();
    textController7.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    replaces = [];
    textController1.text = "";
    textController2.text = "";
    textController3.text = "";
    textController4.text = "";
    textController5.text = "";
    textController6.text = "";
    textController7.text = "";
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
        _returnSplittedVerse(widget.verse[widget.translate]),
        Container(height: 8.0,),
        ElevatedButton(
          child: Text("Проверить", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          onPressed: _checkIsTrue,
        )
      ],
    );
  }

  _returnSplittedVerse(String verse) {
    this.verse = verse;
    List<String> splitted = verse.split(" ");
    int spaces = 0;
    if (widget.level == 1) spaces = 3;
    else if (widget.level == 2) spaces = 5;
    else spaces = 7;

    var random = new Random();
    List positions = [];

    int space = 1;
    while (space <= spaces) {
      while (true) {
        int pos = random.nextInt(splitted.length);
        print(_checkAlphabet(splitted[pos]));
        if (!positions.contains(pos) && _checkAlphabet(splitted[pos])) {
          positions.add(pos);
          break;
        }
      }
      space++;
    }

    List<String> replacesSort = [];
    List<Widget> forReturn = [];
    String str = "";
    int pos = 1;
    for (int i = 0; i < splitted.length; i++) {
      if (positions.contains(i)) {
        String start = "", end = "", word = "";
        for (String char in splitted[i].characters) {
          if (!alphabet.contains(char)) {
            if (word == "") {
              start = start + char;
            } else {
              end = end + char;
            }
          } else {
            word = word + char;
          }
        }
        print(start);
        print(word);
        print(end);
        if (str != "") {
          forReturn.add(Padding(
            padding: const EdgeInsets.all(4.0),
            child: Align(alignment: Alignment.centerLeft,child: Text(str, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500), textAlign: TextAlign.left,)),
          ));
          str = "";
        }
        TextEditingController controller;
        switch (pos) {
          case 1:
            controller = textController1;
            break;
          case 2:
            controller = textController2;
            break;
          case 3:
            controller = textController3;
            break;
          case 4:
            controller = textController4;
            break;
          case 5:
            controller = textController5;
            break;
          case 6:
            controller = textController6;
            break;
          case 7:
            controller = textController7;
            break;
        }
        forReturn.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: <Widget>[
              Text(start + " ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              Flexible(child: CupertinoTextField(autofocus: true, controller: controller, style: TextStyle(color: widget.theme.secondaryHeaderColor),)),
              Text(" " + end, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            ]
          ),
        ));
        replaces.add(word);
        replacesSort.add(word);
        pos += 1;
      } else {
        str += splitted[i];
        str += " ";
      }
    }
    if (str != "") {
      forReturn.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Align(alignment: Alignment.centerLeft,child: Text(str, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500), textAlign: TextAlign.left,)),
      ));
    }


    print(splitted);
    print(positions);
    print(replaces);

    replacesSort.sort();

    return Column(
      children: [
        Container(
          height: 60.0,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            for (String replace in replacesSort) Padding(
              padding: const EdgeInsets.all(2.0),
              child: Chip(label: Text(replace, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),), backgroundColor: secondaryVariant),
            ),
          ],),
        ),
        for (Widget part in forReturn) part
      ],
    );
  }

  Future<void> _checkIsTrue() async {
    int pos = 1;
    bool isTrue = true;
    for (String replace in replaces) {
      TextEditingController controller;
      switch (pos) {
        case 1:
          controller = textController1;
          break;
        case 2:
          controller = textController2;
          break;
        case 3:
          controller = textController3;
          break;
        case 4:
          controller = textController4;
          break;
        case 5:
          controller = textController5;
          break;
        case 6:
          controller = textController6;
          break;
        case 7:
          controller = textController7;
          break;
      }
      if (replace.toLowerCase() != controller.text.toLowerCase().replaceAll(" ", "")) {
        isTrue = false;
      }
      pos += 1;
    }
    Color color = errorMain;
    String title = "Неправильно!";
    if (isTrue) {
      color = successMain;
      title = "Все верно!";
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24),),
          content: Text(verse, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (isTrue) widget.callbackNext(1);
                else widget.callbackNext(0);
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(Colors.white30)
              ),
              child: Text('Далее', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
            ),
          ],
        );
      },
    );
  }

  bool _checkAlphabet(String word) {
    for (String char in word.characters) {
      if (alphabet.contains(char)) {
        return true;
      }
    }
    return false;
  }
}

class FinalTrainingPage extends StatefulWidget {
  final List progress;
  final int level;
  final Function callbackRepeat;

  const FinalTrainingPage(this.progress, this.level, this.callbackRepeat);

  @override
  _FinalTrainingPageState createState() => _FinalTrainingPageState();
}

class _FinalTrainingPageState extends State<FinalTrainingPage> {
  @override
  Widget build(BuildContext context) {
    String textTitle, textRes, textSubtitle;
    if (widget.progress.reduce((a, b) => a + b) > 6) {
      textTitle = "Поздравляем! Вы прошли тренировку";
      textRes = "Ваш результат: " + widget.progress.reduce((a, b) => a + b).toString() + "/12";
      if (widget.level < 3) {
        textSubtitle = "Вы неплохо справились с заданиями. Теперь можно попробовать новую сложность";
      } else {
        if (widget.progress.reduce((a, b) => a + b) == 12) {
          textSubtitle = "Congratulations! Вы идеально знаете этот квартал, так что советуем отдохнуть";
        } else {
          textSubtitle = "Вы неплохо справились с заданиями. Но еще есть куда стремиться!";
        }
      }
    } else {
      textTitle = "К сожалению, вы не прошли тренировку";
      textRes = "Ваш результат: " + widget.progress.reduce((a, b) => a + b).toString() + "/12";
      textSubtitle = "Рекомендуем повторить этот квартал и попробовать еще раз, либо понизить сложность";
    }
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        Text(textTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        Padding(padding: EdgeInsets.all(2.0)),
        Text(textRes, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        Padding(padding: EdgeInsets.all(2.0)),
        Text(textSubtitle, style: TextStyle(fontSize: 16),),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                    onPressed: () {
                      widget.callbackRepeat();
                    },
                    child: Text("Еще раз", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Закрыть", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}