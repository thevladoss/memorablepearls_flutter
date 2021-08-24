import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class SettingsPage extends StatefulWidget  {
  Function callbackApp;
  Function callbackMain;

  SettingsPage(this.callbackApp, this.callbackMain);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("ИПБ"),
    1: Text("Синодальный")
  };
  bool _isDark = false;
  TextEditingController nameController = new TextEditingController(text: "");
  TextEditingController cityController = new TextEditingController(text: "");
  String nameErrorText;
  String cityErrorText;

  @override
  void initState() {
    super.initState();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    Color color;
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      color = secondary;
    } else {
      color = primary;
    }
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Container(
            child: TextFormField(
              autofocus: true,
              onChanged: (text) {
                if (text.length > 1) {
                  setState(() {
                    nameErrorText = null;
                  });
                  saveString("name", text);
                  this.widget.callbackMain();
                } else {
                  setState(() {
                    nameErrorText = "Введите хотя бы два символа";
                  });
                }
              },
              cursorColor: color,
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Имя",
                errorText: nameErrorText,
                border: OutlineInputBorder(),
              ),
            )
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        Container(
          child: TextFormField(
            onChanged: (text) {
              if (text.length > 1) {
                setState(() {
                  cityErrorText = null;
                });
                saveString("city", text);
                this.widget.callbackMain();
              } else {
                setState(() {
                  cityErrorText = "Введите хотя бы два символа";
                });
              }
            },
            cursorColor: color,
            controller: cityController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.location_city),
              errorText: cityErrorText,
              labelText: "Город",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 8)),
        CupertinoSlidingSegmentedControl(
          padding: EdgeInsets.all(4.0),
          groupValue: segmentedControlGroupValue,
          children: myTabs,
          onValueChanged: (i) {
            setState(() {
              switch (i) {
                case 0:
                  saveString("translate", "bti");
                  break;
                case 1:
                  saveString("translate", "rst");
                  break;
              }
              segmentedControlGroupValue = i;
            });
        }),
        ListTile(
          title: const Text('Темная тема', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          trailing: CupertinoSwitch(
            activeColor: theme.accentColor,
            value: _isDark,
            onChanged: (bool value) {
              setState(() {
                _isDark = value;
              });
              if (_isDark) {
                saveString("theme", "dark");
                this.widget.callbackApp(ThemeMode.dark);
              } else {
                saveString("theme", "light");
                this.widget.callbackApp(ThemeMode.light);
              }
            },
          ),
          onTap: () {
            setState(() {
              _isDark = !_isDark;
            });
            if (_isDark) {
              saveString("theme", "dark");
              this.widget.callbackApp(ThemeMode.dark);
            } else {
              saveString("theme", "light");
              this.widget.callbackApp(ThemeMode.light);
            }
          },

        ),
      ],
    );
  }

  void loadData() async {
    var pref = await SharedPreferences.getInstance();
    var c = pref.getString("city");
    var n = pref.getString("name");
    var t = pref.getString("translate");
    var th = pref.getString("theme");
    setState(() {
      if (th == "dark") {
        _isDark = true;
      }
      cityController = new TextEditingController(text: c);
      nameController = new TextEditingController(text: n);
      if (t == "rst") {
        segmentedControlGroupValue = 1;
      }
    });
  }
}