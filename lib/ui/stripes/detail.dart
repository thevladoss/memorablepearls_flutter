import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../main.dart';



class DetailStripePage extends StatefulWidget  {
  final ThemeData theme;
  final String name;
  final String img;
  final String text;
  final String link;
  final String category;

  const DetailStripePage(this.theme, this.name, this.img, this.text, this.link, this.category);

  @override
  _DetailStripePageState createState() => _DetailStripePageState();
}

class _DetailStripePageState extends State<DetailStripePage> {
  Color color;
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Назад',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: color,
          title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                tooltip: 'Поделиться',
                onPressed: () {
                  Share.share(widget.link);
                }
            )
          ],
        ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Image.network(widget.img,
                  errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                    return Container();
                  },),
                Html(
                  data: widget.text,
                  padding: EdgeInsets.all(16),
                  defaultTextStyle: TextStyle(fontSize: 18),
                )
              ]
          ),
        ),
      ),
    );
  }
}