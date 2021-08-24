import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';
import 'detail.dart';

class CategoryPage extends StatefulWidget {
  String category;
  String title;
  ThemeData theme;

  CategoryPage(this.theme, this.category, this.title);


  @override
  State<StatefulWidget> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  List _items = [];
  Widget _appBar;
  TextEditingController _searchController = TextEditingController();
  String _filter = "";

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/stripes/'+widget.category+'.json');
    var data = await json.decode(response);
    if (_filter != "") {
      List<dynamic> newData = [];
      int i = 0;
      for (var d in data) {
        if (d["name"].toString().toLowerCase().contains(_filter)) {
          newData.add(d);
        }
        i += 1;
      }
      if (newData.isEmpty) {
        newData.add({});
      }
      data = newData;
    }
    setState(() {
      _items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    Widget body;
    Color color;

    body = Scrollbar(
      child: GridView.builder(
          padding: EdgeInsets.all(16.0), scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16
          ),
          itemCount: _items.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
              borderOnForeground: true,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        DetailStripePage(
                            widget.theme,
                            _items[index]["name"],
                            _items[index]["img"],
                            _items[index]["text"],
                            _items[index]["link"],
                            widget.category
                        )
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      _items[index]["preview"],
                      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                        return Container();
                      },
                    ),
                    Padding(padding: EdgeInsets.all(4.0),),
                    Text(
                      _items[index]["name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
    switch (widget.category) {
      case "activity":
        color = activityColor;
        break;
      case "adra":
        color = adraColor;
        break;
      case "art":
        color = artColor;
        break;
      case "country":
        color = countryColor;
        break;
      case "dom":
        color = domColor;
        break;
      case "duh":
        color = duhColor;
        break;
      case "health":
        color = healthColor;
        break;
      case "nature":
        color = natureColor;
        break;
      case "pro":
        color = proColor;
        break;
      default:
        color = widget.theme.primaryColor;
        break;
    }
    if (_items.length == 0) body = LinearProgressIndicator(backgroundColor: color,);
    else if (_items[0].isEmpty) body = Container();
    if (_appBar == null) {
      _appBar = _defaultAppBar(color);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar,
      body: body,
    );
  }

  Widget _defaultAppBar(Color color) {
    return AppBar(
      title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        tooltip: 'Назад',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: color,
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Поиск',
          onPressed: () {
            setState(() {
              _appBar = _searchAppBar(color);
            });

          },
        ),
      ],
    );
  }

  Widget _searchAppBar(Color color) {
    _searchController.addListener(() {
      setState(() {
        _filter = _searchController.text;
      });
    });
    return AppBar(
      title: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        controller: _searchController,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            labelText: "Поиск..."
        ),
        autofocus: true,
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        tooltip: 'Назад',
        onPressed: () {
          setState(() {
            _filter = "";
            _appBar = _defaultAppBar(color);
          });
        },
      ),
      backgroundColor: color,
      centerTitle: true,
    );
  }
}