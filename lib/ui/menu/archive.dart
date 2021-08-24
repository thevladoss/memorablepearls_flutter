import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../main.dart';
import '../memorablepearls/detail.dart';


class ArchivePage extends StatefulWidget  {
  final Pages season;
  final TabController controller;
  final ThemeData theme;

  const ArchivePage(this.season, this.controller, this.theme);

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> with SingleTickerProviderStateMixin {
  List _items = [];
  Pages _lastPage;
  String _translate;
  List _calendar;
  
  Future<void> readJson() async {
    String seas;
    int year;
    switch (widget.season) {
      case Pages.SEASON1:
        seas = "1s";
        year = returnMenuYears()[0];
        break;
      case Pages.SEASON2:
        seas = "2s";
        year = returnMenuYears()[1];
        break;
      case Pages.SEASON3:
        seas = "3s";
        year = returnMenuYears()[2];
        break;
      case Pages.SEASON4:
        seas = "4s";
        year = returnMenuYears()[3];
        break;
      case Pages.SEASON5:
        seas = "5s";
        year = returnMenuYears()[4];
        break;
      case Pages.SEASON6:
        seas = "6s";
        year = returnMenuYears()[5];
        break;
    }
    final String response = await rootBundle.loadString('assets/text/'+seas+'.json');
    final data = await json.decode(response);
    var pref = await SharedPreferences.getInstance();
    final String translate = pref.getString("translate");
    setState(() {
      _translate = translate;
      _items = data;
      _lastPage = widget.season;
      _calendar = returnCalendar(year);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty || _lastPage != widget.season) readJson();
    return TabBarView(
      controller: widget.controller,
      children: [
        _items.isNotEmpty ? returnQuart(0) : Container(),
        _items.isNotEmpty ? returnQuart(1) : Container(),
        _items.isNotEmpty ? returnQuart(2) : Container(),
        _items.isNotEmpty ? returnQuart(3) : Container(),
      ]
    );
  }

  Widget returnQuart(int id) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            _items[id]["name_quarter"],
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          )
        ),
        Expanded(
          child: ListView.builder(
            key: ObjectKey(_items[id]["weeks"][0]),
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
            itemCount: _items[id]["weeks"].length,
            itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: InkWell(
                    highlightColor: widget.theme.highlightColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            DetailPage(
                                widget.theme,
                                _items[id]["weeks"][index]["verse"]["link_small_rst"],
                                _items[id]["weeks"][index]["verse"]["link_small_bti"],
                                _items[id]["weeks"][index]["verse"]["link_full_rst"],
                                _items[id]["weeks"][index]["verse"]["link_full_bti"],
                                _items[id]["weeks"][index]["verse"]["rst"],
                                _items[id]["weeks"][index]["verse"]["bti"],
                                _items[id]["weeks"][index]["num_week_in_year"].toString() + " неделя, " + _calendar[_items[id]["weeks"][index]["num_week_in_year"]-1]
                            )
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
                                      new TextSpan(text: _items[id]["weeks"][index]["verse"]["link_small_"+_translate] + " ", style: new TextStyle(fontWeight: FontWeight.bold)),
                                      new TextSpan(text: _items[id]["weeks"][index]["verse"][_translate]),
                                    ],
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.copy),
                                title: Text('Скопировать'),
                                onTap: () {
                                  Clipboard.setData(new ClipboardData(text: _items[id]["weeks"][index]["verse"]["link_small_"+_translate] + " " + _items[id]["weeks"][index]["verse"][_translate]));
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
                                  Share.share(_items[id]["weeks"][index]["verse"]["link_small_"+_translate] + " " + _items[id]["weeks"][index]["verse"][_translate]);
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
                            child: Text(_items[id]["weeks"][index]["num_week_in_year"].toString() + " неделя, " + _calendar[_items[id]["weeks"][index]["num_week_in_year"]-1], style: TextStyle(fontSize: 15),),
                          ),
                          ListTile(
                            title: Text(_items[id]["weeks"][index]["verse"][_translate], style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(_items[id]["weeks"][index]["verse"]["link_small_"+_translate], textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            },
          ),
        ),
      ],
    );
  }


}

List returnCalendar(int year) {
  initializeDateFormatting("ru");
  Intl.defaultLocale = "ru";
  var formatPart1 = DateFormat("d MMMM");
  var formatPart2 = DateFormat("d");
  var formatPart3 = DateFormat("d MMMM y");
  var firstDayOfYear = DateTime.utc(year);
  var firstSabbath = firstDayOfYear;
  var datesArray = [];

  int iterations = 52;

  switch(firstDayOfYear.weekday) {
    case 1:
      firstSabbath = firstSabbath.add(Duration(days: 5));
      iterations = 53;
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
      friday = lastSabbath.add(Duration(days: 6));
      i++;
    } else {
      sabbath = lastSabbath;
      friday = lastSabbath.add(Duration(days: 6));
    }
    String start, end;
    if (sabbath.year != friday.year) {
      start = formatPart3.format(sabbath);
      end = formatPart3.format(friday);
    } else if (sabbath.month != friday.month) {
      start = formatPart1.format(sabbath);
      end = formatPart3.format(friday);
    } else {
      start = formatPart2.format(sabbath);
      end = formatPart3.format(friday);
    }
    datesArray.add(start + " — " + end);
    lastSabbath = friday.add(Duration(days: 1));
  }

  return datesArray;
}
