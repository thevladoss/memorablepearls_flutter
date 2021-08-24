import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';


class DetailPage extends StatefulWidget  {
  final ThemeData theme;
  final String verseShortRST;
  final String verseShortBTI;
  final String verseLongRST;
  final String verseLongBTI;
  final String textRST;
  final String textBTI;
  final String dateWeek;

  const DetailPage(this.theme, this.verseShortRST, this.verseShortBTI, this.verseLongRST, this.verseLongBTI, this.textRST, this.textBTI, this.dateWeek);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String verseShort = "";
  String verseLong = "";
  String text = "";
  String trans = "";

  Future<void> initTranslate() async {
    var pref = await SharedPreferences.getInstance();
    final String translate = pref.getString("translate");
    setState(() {
      if (trans == "") {
        if (translate == "rst") {
          verseShort = widget.verseShortRST;
          verseLong = widget.verseLongRST;
          text = widget.textRST;
          trans = "rst";
        } else {
          verseShort = widget.verseShortBTI;
          verseLong = widget.verseLongBTI;
          text = widget.textBTI;
          trans = "bti";
        }
      } else {
        if (trans == "bti") {
          verseShort = widget.verseShortBTI;
          verseLong = widget.verseLongBTI;
          text = widget.textBTI;
        } else if (trans == "rst") {
          verseShort = widget.verseShortRST;
          verseLong = widget.verseLongRST;
          text = widget.textRST;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initTranslate();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Назад',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.translate),
            tooltip: 'Сменить перевод',
            onPressed: () {
              String transl;
              if (trans == "rst") {
                trans = "bti";
                transl = "Институт перевода Библии";
              } else if (trans == "bti") {
                trans = "rst";
                transl = "Синодальный перевод";
              }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(transl, style: TextStyle(fontSize: 16),),
              ));

              setState(() {});
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.copy),
          //   tooltip: 'Скопировать',
          //   onPressed: () {
          //     Clipboard.setData(new ClipboardData(text: verseShort + " " + text));
          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       behavior: SnackBarBehavior.floating,
          //       content: Text('Скопировано в буфер обмена!', style: TextStyle(fontSize: 16),),
          //     ));
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.share),
            tooltip: 'Поделиться',
            onPressed: () {
              Share.share(verseShort + " " + text);
            },
          )
        ],
        title: Text(verseShort, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
      ),
      body: Container (
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(widget.dateWeek, style: TextStyle(fontSize: 15),),
            ),
            ListTile(
              title: SelectableText(text, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 4),
                child: SelectableText(verseLong, textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}