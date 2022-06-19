import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memorablepearls_flutter/main.dart';
import 'package:memorablepearls_flutter/ui/memorablepearls/detail.dart';
import 'package:memorablepearls_flutter/ui/menu/archive.dart';
import 'package:memorablepearls_flutter/ui/stripes/detail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final ThemeData theme;
  final Function callbackArchive;
  final Function callbackTraining;

  const HomePage(this.theme, this.callbackArchive, this.callbackTraining);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _load = false;
  List _items = [];
  List _itemsStripe = [];
  String _translate;
  String _category;
  String _hello = "";
  DateTime now = DateTime.now();


  Future<void> readJson(seas) async {
    final String response = await rootBundle.loadString('assets/text/'+seas+'.json');
    final data = await json.decode(response);
    var pref = await SharedPreferences.getInstance();
    final String translate = pref.getString("translate");
    final String name  = pref.getString("name");
    int hour = DateTime.now().hour;
    String hello;
    if (hour <= 10 && hour >= 5) hello = "Доброе утро, " + name + "!";
    else if (hour <= 16) hello = "Добрый день, " + name + "!";
    else if (hour <= 23) hello = "Добрый вечер, " + name + "!";
    else hello = "Доброй ночи, " + name + "!";
    setState(() {
      _translate = translate;
      _items = data;
      _hello = hello;
    });
  }

  Future<void> readJson2(name) async {
    setState(() {
      _load = true;
    });

    final String response = await rootBundle.loadString('assets/stripes/'+name+'.json');
    final data = await json.decode(response);
    setState(() {
      _load = false;
      _itemsStripe = data;
      _category = name;
    });
  }


  @override
  Widget build(BuildContext context) {
    var weekIndex = 52;
    var year = now.year;
    var quart = 3;
    var index = 0;
    var verse = "", link = "";
    DetailPage detail;
    List calendar = returnCalendarInterval(year);
    calendar.forEach((element) {
      if (now.millisecondsSinceEpoch >= element[0] && now.millisecondsSinceEpoch <= element[1]) {
        weekIndex = calendar.indexOf(element);
      }
    });
    if (weekIndex == 52) {
      if (now.millisecondsSinceEpoch >= calendar[51][1]) {
        year = now.year+1;
        weekIndex = 0;
      } else {
        year = now.year-1;
        weekIndex = 51;
      }
      calendar = returnCalendarInterval(year);
    }
    if (_items.isEmpty) readJson(returnSeasByYear(year));
    var seas, seasName;
    switch (returnSeasByYear(year)) {
      case "1s":
        seas = Pages.SEASON1;
        seasName = "1 сезон";
        break;
      case "2s":
        seas = Pages.SEASON2;
        seasName = "2 сезон";
        break;
      case "3s":
        seas = Pages.SEASON3;
        seasName = "3 сезон";
        break;
      case "4s":
        seas = Pages.SEASON4;
        seasName = "4 сезон";
        break;
      case "5s":
        seas = Pages.SEASON5;
        seasName = "5 сезон";
        break;
      case "6s":
        seas = Pages.SEASON6;
        seasName = "6 сезон";
        break;
    }
    if (weekIndex < 13) {
      quart = 0;
      index = weekIndex;
    }  else if (weekIndex < 26) {
      quart = 1;
      index = weekIndex-13;
    } else if (weekIndex < 39) {
      quart = 2;
      index = weekIndex-26;
    } else {
      index = weekIndex-39;
    }
    if (_items.isNotEmpty) {
      verse = _items[quart]["weeks"][index]["verse"][_translate];
      link = _items[quart]["weeks"][index]["verse"]["link_small_"+_translate];
      detail = DetailPage(
          widget.theme,
          _items[quart]["weeks"][index]["verse"]["link_small_rst"],
          _items[quart]["weeks"][index]["verse"]["link_small_bti"],
          _items[quart]["weeks"][index]["verse"]["link_full_rst"],
          _items[quart]["weeks"][index]["verse"]["link_full_bti"],
          _items[quart]["weeks"][index]["verse"]["rst"],
          _items[quart]["weeks"][index]["verse"]["bti"],
          _items[quart]["weeks"][index]["num_week_in_year"].toString() + " неделя, " + returnCalendar(year)[weekIndex]
      );
    }
    if (_itemsStripe.isNotEmpty) {
      final _random = new Random();
      var item = _itemsStripe[_random.nextInt(_itemsStripe.length)];
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              DetailStripePage(
                  widget.theme,
                  item["name"],
                  item["img"],
                  item["text"],
                  item["link"],
                  _category
              )
          ),
        );
      });
      _itemsStripe = [];
    }


    return ListView(
      children: [
        if (_load) LinearProgressIndicator(color: secondary, backgroundColor: primary,),
        Padding(padding: EdgeInsets.all(8.0)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:  16.0),
          child: Text(_hello, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
          ), textAlign: TextAlign.center),
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: InkWell(
              highlightColor: widget.theme.highlightColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      detail
                  ),
                );
              },
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
                          child: RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: widget.theme.secondaryHeaderColor,
                              ),
                              children: <TextSpan>[
                                new TextSpan(text: link + " ", style: new TextStyle(fontWeight: FontWeight.bold)),
                                new TextSpan(text: verse),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.copy),
                          title: Text('Скопировать'),
                          onTap: () {
                            Clipboard.setData(new ClipboardData(text: link + " " + verse));
                            Scaffold.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text('Скопировано в буфер обмена!', style: TextStyle(fontSize: 16),),
                            ));
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.share),
                          title: Text('Поделиться'),
                          onTap: () {
                            Share.share(link + " " + verse);
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          height: 16.0,
                        )
                      ],
                    );
                  },
                );
              },
              child: Container (
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text((weekIndex+1).toString() + " неделя, " + returnCalendar(year)[weekIndex], style: TextStyle(fontSize: 15),),
                    ),
                    ListTile(
                      title: Text(verse, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(link, textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            onTap: () => _selectDate(context),
            title: Text('Дата'),
            subtitle: Text('Хотите узнать, какой стих вас ожидает?'),
            leading: Icon(Icons.calendar_today),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            onTap: () {
              List files = ["adra", "art", "activity", "country", "dom", "duh", "health", "nature", "pro", "special"];
              final _random = new Random();
              var fileName = files[_random.nextInt(files.length)];
              readJson2(fileName);
            },
            title: Text('Случайная специализация'),
            subtitle: Text('Может быть вы захотите ее пройти'),
            leading: Icon(Icons.format_list_bulleted),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            onTap: () {
              this.widget.callbackArchive(seas, seasName, quart);
            },
            title: Text('Текущий квартал'),
            subtitle: Text('Все Памятные Жемчужины текущего квартала'),
            leading: Icon(Icons.looks_5_rounded),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            onTap: () {
              this.widget.callbackTraining(seasName, quart);
            },
            title: Text('Тренировка текущего квартала'),
            subtitle: Text('Поможет в запоминании актуальных Памятных Жемчужин'),
            leading: Icon(Icons.fitness_center_rounded),
          ),
        ),

      ],
    );
  }

  List returnCalendarInterval(int year) {
    var firstDayOfYear = DateTime.utc(year);
    var firstSabbath = firstDayOfYear;
    var datesArray = [];

    int iterations = 52;

    switch(firstDayOfYear.weekday) {
      case 1:
        firstSabbath = firstSabbath.add(Duration(days: 5));
        break;
      case 2:
        firstSabbath = firstSabbath.add(Duration(days: 4));
        break;
      case 3:
        firstSabbath = firstSabbath.add(Duration(days: 3));
        break;
      case 4:
        firstSabbath = firstSabbath.add(Duration(days: 2));
        break;
      case 5:
        firstSabbath = firstSabbath.add(Duration(days: 1));
        break;
      case 7:
        firstSabbath = firstSabbath.add(Duration(days: 6));
        iterations = 53;
        break;
      default:
        break;
    }


    var lastSabbath = firstSabbath;

    for(int i = 0; i < iterations; i++) {
      DateTime sabbath, friday;
      if (i == 0 && iterations == 53) {
        sabbath = lastSabbath.subtract(Duration(days: 7));
        i++;
      } else {
        sabbath = lastSabbath;
      }
      friday = lastSabbath.add(Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
      datesArray.add([sabbath.millisecondsSinceEpoch, friday.millisecondsSinceEpoch]);
      lastSabbath = friday.subtract(Duration(hours: 23, minutes: 59, seconds: 59)).add(Duration(days: 1));
    }

    return datesArray;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(returnMenuYears()[0]),
        lastDate: DateTime(returnMenuYears()[5], 12, 31),
        locale: Locale("ru", "RU")
    );
    if (pickedDate != null && pickedDate != now) {
      setState(() {
        now = pickedDate.add(Duration(hours: 12));
      });
    }
  }
}