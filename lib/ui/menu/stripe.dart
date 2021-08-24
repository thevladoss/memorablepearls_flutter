import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorablepearls_flutter/ui/stripes/category.dart';

import '../../main.dart';

class StripePage extends StatefulWidget {
  final ThemeData theme;
  Function changePage;

  StripePage(this.theme, this.changePage);

  @override
  _StripePageState createState() => _StripePageState();
}

class _StripePageState extends State<StripePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        ListTile(
          title: Text('ADRA', style: textTitleStyle(),),
          leading: Icon(Icons.support),
          trailing: Text('9 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "adra", "ADRA")),
            );

          },
        ),
        ListTile(
          title: Text('Активный отдых', style: textTitleStyle(),),
          leading: Icon(Icons.pool),
          trailing: Text('80 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "activity", "Активный отдых")),
            );
          },
        ),
        ListTile(
          title: Text('Духовный рост, служение обществу и наследие', style: textTitleStyle(),),
          leading: Icon(Icons.spa),
          trailing: Text('31 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "duh", "Духовный рост, служение обществу и наследие")),
            );
          },
        ),
        ListTile(
          title: Text('Домоводство', style: textTitleStyle(),),
          leading: Icon(Icons.house),
          trailing: Text('18 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "dom", "Домоводство")),
            );
          },
        ),
        ListTile(
          title: Text('Здоровье и наука', style: textTitleStyle(),),
          leading: Icon(Icons.biotech),
          trailing: Text('18 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "health", "Здоровье и наука")),
            );
          },
        ),
        ListTile(
          title: Text('Искусство, ремесла и хобби', style: textTitleStyle(),),
          leading: Icon(Icons.palette),
          trailing: Text('89 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "art", "Искусство, ремесла и хобби")),
            );
          },
        ),
        ListTile(
          title: Text('Природа', style: textTitleStyle(),),
          leading: Icon(Icons.landscape),
          trailing: Text('79 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "nature", "Природа")),
            );
          },
        ),
        ListTile(
          title: Text('Профессиональные навыки', style: textTitleStyle(),),
          leading: Icon(Icons.lightbulb),
          trailing: Text('36 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "pro", "Профессиональные навыки")),
            );
          },
        ),
        ListTile(
          title: Text('Сельскохозяйственные навыки', style: textTitleStyle(),),
          leading: Icon(Icons.agriculture),
          trailing: Text('15 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "country", "Сельскохозяйственные навыки")),
            );
          },
        ),
        ListTile(
          title: Text('Специалист', style: textTitleStyle(),),
          leading: Icon(Icons.school),
          trailing: Text('12 шт'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(widget.theme, "special", "Специалист")),
            );
          },
        ),
      ],
    );
  }

  textTitleStyle() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold
    );
  }
}