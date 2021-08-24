import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:memorablepearls_flutter/main.dart';

import '../training.dart';

class TrainingPage extends StatefulWidget {
  final ThemeData theme;
  final String seasonName;
  final int quartIndex;

  TrainingPage(this.theme, this.seasonName, this.quartIndex);

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {

  bool _isLoad = false;
  List<String> seasons = [
    "1 сезон",
    "2 сезон",
    "3 сезон",
    "4 сезон",
    "5 сезон",
    "6 сезон",
  ];
  List<String> quarts = [
    "1 квартал",
    "2 квартал",
    "3 квартал",
    "4 квартал",
  ];
  List<String> levels = [
    "Легкая",
    "Средняя",
    "Сложная",
  ];
  String seasonStr = "1 сезон", quartStr = "1 квартал", levelStr = "Легкая";
  int season = 0, quart = 0, level = 1;

  Future<void> readJson(seas, qua, lev) async {
    setState(() {
      _isLoad = true;
    });

    final String response = await rootBundle.loadString('assets/text/'+seas+'.json');
    final data = await json.decode(response);

    setState(() {
      _isLoad = false;
    });

    List newList = [];

    for (int i = 0; i < 12; i += 1) {
      newList.add(data[qua]["weeks"][i]);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailTrainingPage(shuffle(newList), lev, widget.theme)),
    );
  }

  @override
  void initState() {
    quart = widget.quartIndex;
    switch (widget.quartIndex) {
      case 1:
        quartStr = "2 квартал";
        break;
      case 2:
        quartStr = "3 квартал";
        break;
      case 3:
        quartStr = "4 квартал";
        break;
    }

    seasonStr = widget.seasonName;
    switch (widget.seasonName) {
      case "2 сезон":
        season = 1;
        break;
      case "3 сезон":
        season = 2;
        break;
      case "4 сезон":
        season = 3;
        break;
      case "5 сезон":
        season = 4;
        break;
      case "6 сезон":
        season = 5;
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        if (_isLoad) LinearProgressIndicator(color: secondary, backgroundColor: primary,),
        Padding(padding: EdgeInsets.all(8.0)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("• 12 Памятных Жемчужин", style: TextStyle(fontSize: 18),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("• Необходимо заполнить пропуски в стихе", style: TextStyle(fontSize: 18),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("• Сложность определяет количество пропусков", style: TextStyle(fontSize: 18),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("• 3 попытки на каждый стих", style: TextStyle(fontSize: 18),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("• Устали? Можно завершить досрочно, нажав на крестик", style: TextStyle(fontSize: 18),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text("Выберите сезон:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text('Выберите сезон', style: TextStyle(fontWeight: FontWeight.bold),),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  seasonStr = seasons[0];
                                  season = 0;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(seasons[0], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  seasonStr = seasons[1];
                                  season = 1;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(seasons[1], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  seasonStr = seasons[2];
                                  season = 2;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(seasons[2], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  seasonStr = seasons[3];
                                  season = 3;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(seasons[3], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  seasonStr = seasons[4];
                                  season = 4;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(seasons[4], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  seasonStr = seasons[5];
                                  season = 5;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(seasons[5], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                          ],
                        );
                      });
                },
                child: Text(seasonStr),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text("Выберите квартал:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text('Выберите квартал', style: TextStyle(fontWeight: FontWeight.bold),),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  quartStr = quarts[0];
                                  quart = 0;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(quarts[0], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  quartStr = quarts[1];
                                  quart = 1;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(quarts[1], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  quartStr = quarts[2];
                                  quart = 2;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(quarts[2], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  quartStr = quarts[3];
                                  quart = 3;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(quarts[3], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                          ],
                        );
                      });
                },
                child: Text(quartStr),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text("Выберите сложность:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text('Выберите сложность', style: TextStyle(fontWeight: FontWeight.bold),),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  levelStr = levels[0];
                                  level = 1;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(levels[0], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  levelStr = levels[1];
                                  level = 2;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(levels[1], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  levelStr = levels[2];
                                  level = 3;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(levels[2], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                          ],
                        );
                      });
                },
                child: Text(levelStr),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            style: ButtonStyle(

            ),
            onPressed: () {
              readJson((season+1).toString()+"s", quart, level);
            },
            child: const Text('Начать тренировку', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          ),
        ),
      ],
    );
  }

  shuffle(items) {
    var random = new Random();
    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }
}