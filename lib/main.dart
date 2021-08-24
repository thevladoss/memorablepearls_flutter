import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memorablepearls_flutter/ui/hello.dart';
import 'package:memorablepearls_flutter/ui/menu/about.dart';
import 'package:memorablepearls_flutter/ui/menu/hymn.dart';
import 'package:memorablepearls_flutter/ui/menu/law.dart';
import 'package:memorablepearls_flutter/ui/menu/stripe.dart';
import 'package:memorablepearls_flutter/ui/memorablepearls/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ui/menu/home.dart';
import 'ui/menu/training.dart';
import 'ui/menu/settings.dart';
import 'ui/menu/archive.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

enum Pages
{
  HOME,
  LAW,
  HYMN,
  STRIPE,
  TRAINING,
  SETTINGS,
  ABOUT,
  SEASON1,
  SEASON2,
  SEASON3,
  SEASON4,
  SEASON5,
  SEASON6,
}

const Color adraColor = Color(0xFF3d2b6d);
const Color activityColor = Color(0xFF365844);
const Color artColor = Color(0xFF25a0b0);
const Color countryColor = Color(0xFF6e401f);
const Color domColor = Color(0xFFae6928);
const Color duhColor = Color(0xFF302e85);
const Color healthColor = Color(0xFF6c2c8b);
const Color natureColor = Color(0xFF9f8e72);
const Color proColor = Color(0xFF992427);

const Color onPrimary = Color(0xFFFFFFFF);
const Color primary = Color(0xFF6200EE);
const Color primaryVariant = Color(0xFF3700B3);
const Color onSecondary = Color(0xFF000000);
const Color secondary = Color(0xFF03DAC6);
const Color secondaryVariant = Color(0xFF018786);

const Color onError = Color(0xFFFFFFFF);
const Color error = Color(0xFFB00020);
const Color errorVariant = Color(0xFFD94E67);

const Color errorDark = Color(0xFFd32f2f);
const Color errorMain = Color(0xFFf44336);
const Color errorLight = Color(0xFFe57373);
const Color successDark = Color(0xFF388e3c);
const Color successMain = Color(0xFF4caf50);
const Color successLight = Color(0xFF81c784);

const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);

const ColorScheme _lightColorScheme = ColorScheme(
  primary: primary,
  primaryVariant: primaryVariant,
  secondary: secondary,
  secondaryVariant: secondaryVariant,
  surface: white,
  background: white,
  error: error,
  onPrimary: onPrimary,
  onSecondary: onSecondary,
  onSurface: black,
  onBackground: black,
  onError: onError,
  brightness: Brightness.light,
);

const ColorScheme _darkColorScheme = ColorScheme(
  primary: secondary,
  primaryVariant: secondaryVariant,
  secondary: primary,
  secondaryVariant: secondaryVariant,
  surface: black,
  background: black,
  error: errorVariant,
  onPrimary: onPrimary,
  onSecondary: onSecondary,
  onSurface: white,
  onBackground: white,
  onError: onError,
  brightness: Brightness.dark,
);


void main() {
  runApp(MPApp());
}

class MPApp extends StatefulWidget {
  @override
  _MPAppState createState() => _MPAppState();
}

class _MPAppState extends State<MPApp> {
  final appTitle = 'Главная';
  ThemeMode theme = ThemeMode.light;
  MainPage mainPage;

  @override
  void initState() {
    super.initState();
    mainPage = MainPage(appTitle, this.callback);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: mainPage,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru'),
      ],
    );
  }

  void callback(ThemeMode theme) {
    setState(() {
      this.theme = theme;
    });
  }

  ThemeData _buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: _lightColorScheme,
      brightness: Brightness.light,
      toggleableActiveColor: secondary,
      accentColor: secondary,
      primaryColor: primary,
      primaryColorDark: primaryVariant,
      buttonColor: secondaryVariant,
      errorColor: error,
      secondaryHeaderColor: black // Цвет текста
    );
  }

  ThemeData _buildDarkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      colorScheme: _darkColorScheme,
      brightness: Brightness.dark,
      toggleableActiveColor: secondary,
      accentColor: secondary,
      primaryColor: primary,
      primaryColorDark: primaryVariant,
      buttonColor: secondaryVariant,
      errorColor: errorVariant,
      secondaryHeaderColor: white // Цвет текста
    );
  }


}



class MainPage extends StatefulWidget {
  String title;
  Function callback;

  MainPage(this.title, this.callback);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  var page = Pages.HOME;
  List<String> quarts = [
    "1 квартал",
    "2 квартал",
    "3 квартал",
    "4 квартал",
  ];
  List<double> quartsNum = [
    20,
    16,
    16,
    16,
  ];
  TabController _controller;
  var isAuth = "null";
  String city = "";
  String name = "";
  String avatar = "";
  String category;
  int initialTabIndex = 0;
  String initialSeason = "1 сезон";
  int initialQuartIndex = 0;

  Future<void> _launchEmail() async {
    final url = "mailto:osinvladislav@yandex.ru";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Электронная почта', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
          content: const SelectableText('osinvladislav@yandex.ru', style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ЗАКРЫТЬ', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
      print('Could not launch $url');
    }
  }

  Future<void> _launchVK() async {
    final url = "https://vk.com/imthevladoss";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ВКонтакте', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
          content: const SelectableText('vk.com/imthevladoss', style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ЗАКРЫТЬ', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
      print('Could not launch $url');
    }
  }

  Future<void> _launchTelegram() async {
    final url = "https://t.me/thevladoss";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Telegram', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
          content: const SelectableText('@thevladoss', style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ЗАКРЫТЬ', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
      print('Could not launch $url');
    }
  }

  Future<void> _launchWhatsApp() async {
    final url = "whatsapp://send?phone=79066379944";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('WhatsApp', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
          content: const SelectableText('+7 (906) 637-99-44', style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ЗАКРЫТЬ', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
      print('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        length: 4,
        vsync: this,
        initialIndex: 0
    );
    _controller.addListener(() {
      setState(() {
        quartsNum = [16, 16, 16, 16];
        quartsNum[_controller.index] = 20;
      });
    });
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var body, action;

    if (isAuth == "true") {
      switch (page) {
        case Pages.HOME:
          body = HomePage(theme, callbackArchive, callbackTraining);
          break;
        case Pages.LAW:
          body = LawPage();
          action = [
            IconButton(
                icon: Icon(Icons.copy),
                tooltip: "Скопировать",
                onPressed: () {
                  Clipboard.setData(new ClipboardData(text: "Обещание следопытов\n" + "С помощью Божьей\nЯ обещаю быть честным, добрым и верным.\nЯ буду соблюдать законы следопытов.\nЯ буду слугою Бога и другом людей.\n\n" + "Закон следопытов\n" + "Начинать день с чтения Библии и молитвы.\nЧестно исполнять свои обязанности.\nЗаботиться о своём теле.\nБыть правдивым.\nБыть вежливым и послушным.\nС благоговением относиться к Богослужению.\nЖить с песней в сердце.\nИсполнять Божьи повеления."));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text('Скопировано в буфер обмена!', style: TextStyle(fontSize: 16),),
                  ));
                }
            )
          ];
          break;
        case Pages.HYMN:
          body = HymnPage();
          action = [
            IconButton(
                icon: Icon(Icons.copy),
                tooltip: "Скопировать",
                onPressed: () {
                  Clipboard.setData(new ClipboardData(text: "Гимн следопытов\n" + "Зовут Следопытами нас.\nМы Божии слуги все,\nВерные во всякий час\nВ доброте и чистоте.\nМы весть всему миру несем,\nСвободу и Божью любовь:\nСпаситель, наш Царь Иисус придет\nЗа нами вновь.\n\nИсследовать истину я\nГотов словно Следопыт,\nИ Творцу всего себя\nЯ желаю посвятить.\nГосподь всем нам дарит любовь\nИ всякую благодать,\nЯ верю, что Царь мой, Иисус,\nПридёт опять!"));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text('Скопировано в буфер обмена!', style: TextStyle(fontSize: 16),),
                  ));
                }
            )
          ];
          break;
        case Pages.STRIPE:
          body = StripePage(theme, changePage);
          break;
        case Pages.TRAINING:
          body = TrainingPage(theme, initialSeason, initialQuartIndex);
          break;
        case Pages.SETTINGS:
          body = SettingsPage(widget.callback, loadData);
          break;
        case Pages.ABOUT:
          body = AboutPage();
          action = [
            IconButton(
                icon: Icon(Icons.contact_support),
                tooltip: "Связь с разработчиком",
                iconSize: 30,
                onPressed: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: const Text('Связь с разработчиком', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
                      message: const Text('Задать свой вопрос, сообщить об ошибке или предложить идею вы можете связавшись по предложенным ниже кнопкам', style: TextStyle(fontSize: 16),),
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text('Закрыть', style: TextStyle(color: errorVariant, fontWeight: FontWeight.w600),),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      actions: <CupertinoActionSheetAction>[
                        CupertinoActionSheetAction(
                          child: const Text('Электронная почта', style: TextStyle(fontWeight: FontWeight.w500)),
                          onPressed: _launchEmail,
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('ВКонтакте', style: TextStyle(fontWeight: FontWeight.w500)),
                          onPressed: _launchVK,
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('Telegram', style: TextStyle(fontWeight: FontWeight.w500)),
                          onPressed: _launchTelegram,
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('WhatsApp', style: TextStyle(fontWeight: FontWeight.w500)),
                          onPressed: _launchWhatsApp,
                        ),
                      ],
                    ),
                  );
                },
            )
          ];
          break;
        case Pages.SEASON1:
          return returnTabsArchive(theme, 0);
          break;
        case Pages.SEASON2:
          return returnTabsArchive(theme, 1);
          break;
        case Pages.SEASON3:
          return returnTabsArchive(theme, 2);
          break;
        case Pages.SEASON4:
          return returnTabsArchive(theme, 3);
          break;
        case Pages.SEASON5:
          return returnTabsArchive(theme, 4);
          break;
        case Pages.SEASON6:
          return returnTabsArchive(theme, 5);
          break;
      }

      return Scaffold(
        appBar: AppBar(
          title: _appBarTitle(widget.title),
          actions: action,
          centerTitle: true,
        ),
        drawer: _drawer(theme),
        body: body,
      );
    } else if(isAuth == "false") {
      return Scaffold(
        appBar: AppBar(
            title: _appBarTitle("Добро пожаловать!"),
            centerTitle: true,
        ),
        body: HelloPage(widget.callback, loadData),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: Container(),
      );
    }
  }

  Widget _appBarTitle(String text) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22));
  }

  Widget returnTabsArchive(ThemeData theme, int i) {
    if (initialTabIndex != 0) {
      _controller.animateTo(initialTabIndex);
      initialTabIndex = 0;
    }
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _controller,
            isScrollable: true,
            indicatorColor: theme.accentColor,
            tabs: [
              Tab(child: _tabBarTitle(quarts[0], quartsNum[0])),
              Tab(child: _tabBarTitle(quarts[1], quartsNum[1])),
              Tab(child: _tabBarTitle(quarts[2], quartsNum[2])),
              Tab(child: _tabBarTitle(quarts[3], quartsNum[3])),
            ],
          ),
          actions: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  tooltip: 'Скачать PDF-файл квартала',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PDFPage(theme, page);
                      }),
                    );
                  },
                )
            )
          ],
          title: _appBarTitle(widget.title),
          centerTitle: true,
        ),
        drawer: _drawer(theme),
        body: ArchivePage(page, _controller, theme)
    );
  }

  Widget _drawer(ThemeData theme) {
    return Drawer(
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: theme.primaryColor,
          child: ListView(
            padding: EdgeInsets.only(bottom: 16),
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text(
                  city,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                accountName: Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26
                  ),
                ),
                currentAccountPicture: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: CircleAvatar(
                    backgroundColor: secondary,
                    foregroundColor: primary,
                    child: Text(avatar, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              _menuItem(Icons.home_rounded, "Главная", null, theme, Pages.HOME),
              _menuItem(Icons.gavel, "Закон и обещание", null, theme, Pages.LAW),
              _menuItem(Icons.queue_music, "Гимн следопытов", null, theme, Pages.HYMN),
              _menuItem(Icons.format_list_bulleted, "Специализации", null, theme, Pages.STRIPE),
              _menuItem(Icons.settings_rounded, "Настройки", null, theme, Pages.SETTINGS),
              _menuItem(Icons.info_outline, "О приложении", null, theme, Pages.ABOUT),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child:Divider(
                  height: 1,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Text(
                  'Памятные Жемчужины',
                ),
              ),
              _menuItem(Icons.fitness_center_rounded, "Тренировка", null, theme, Pages.TRAINING),
              _menuItem(Icons.looks_one_rounded, "1 сезон", Text(returnMenuYears()[0].toString() + " год"), theme, Pages.SEASON1),
              _menuItem(Icons.looks_two_rounded, "2 сезон", Text(returnMenuYears()[1].toString() + " год"), theme, Pages.SEASON2),
              _menuItem(Icons.looks_3_rounded, "3 сезон", Text(returnMenuYears()[2].toString() + " год"), theme, Pages.SEASON3),
              _menuItem(Icons.looks_4_rounded, "4 сезон", Text(returnMenuYears()[3].toString() + " год"), theme, Pages.SEASON4),
              _menuItem(Icons.looks_5_rounded, "5 сезон", Text(returnMenuYears()[4].toString() + " год"), theme, Pages.SEASON5),
              _menuItem(Icons.looks_6_rounded, "6 сезон", Text(returnMenuYears()[5].toString() + " год"), theme, Pages.SEASON6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String text, Text subtext, ThemeData theme, Pages page) {
    Color selectedColor = primary.withAlpha(50);
    if (theme.brightness == Brightness.dark) selectedColor = secondary.withAlpha(50);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon),
      title: Text(text, style: TextStyle(fontSize: 16)),
      subtitle: subtext,
      selectedTileColor: selectedColor,
      selected: this.page == page,
      onTap: () => changePage(page, text, true, 0),
    );
  }

  Widget _tabBarTitle(String text, double size) {
    return Text(text, style: TextStyle(fontSize: size));
  }

  changePage(Pages page, String text, bool isClear, int index) {
    setState(() => {
      widget.title = text,
      this.page = page,
      _controller.animateTo(0),
    });
    if (isClear) {
      Navigator.pop(context);
    }
  }

  void loadData() async {
    var pref = await SharedPreferences.getInstance();
    bool isVal = pref.containsKey("isAuth");
    if (isAuth != isVal.toString()) setState(() {
      isAuth = isVal.toString();
    });
    if (isVal) {
      var th = pref.getString("theme");
      if (th == "dark") {
        widget.callback(ThemeMode.dark);
      }

      var c = pref.getString("city");
      var n = pref.getString("name");
      setState(() {
        city = c;
        name = n;
        avatar = '${n[0]}${n[1]}'.toUpperCase();
      });
    }
  }

  void callbackArchive(Pages page, String name, int index) {
    setState(() {
      changePage(page, name, false, index);
      initialTabIndex = index;
    });
  }

  void callbackTraining(String name, int index) {
    setState(() {
      changePage(Pages.TRAINING, "Тренировка", false, 0);
      initialSeason = name;
      initialQuartIndex = index;
    });
  }


}

String returnSeasByYear(year) {
  int i = year;
  String seas;
  while (i >= 2017) {
    switch (i) {
      case 2017:
        seas = "1s";
        break;
      case 2018:
        seas = "2s";
        break;
      case 2019:
        seas = "3s";
        break;
      case 2020:
        seas = "4s";
        break;
      case 2021:
        seas = "5s";
        break;
      case 2022:
        seas = "6s";
        break;
      default:
        break;
    }
    i = i - 6;
  }
  return seas;
}

List returnMenuYears() {
  DateTime date = DateTime.now();
  int year = date.year;
  int i = year;
  List listYears;
  while (i >= 2017) {
    switch (i) {
      case 2017:
        listYears = [year, year+1, year+2, year+3, year+4, year+5];
        break;
      case 2018:
        listYears = [year-1, year, year+1, year+2, year+3, year+4];
        break;
      case 2019:
        listYears = [year-2, year-1, year, year+1, year+2, year+3];
        break;
      case 2020:
        listYears = [year-3, year-2, year-1, year, year+1, year+2];
        break;
      case 2021:
        listYears = [year-4, year-3, year-2, year-1, year, year+1];
        break;
      case 2022:
        listYears = [year-5, year-4, year-3, year-2, year-1, year];
        break;
      default:
        break;
    }
    i = i - 6;
  }
  return listYears;
}


Future<String> getString(String key) async {
  var pref = await SharedPreferences.getInstance();
  var bool = pref.getString(key) ?? 0;
  return bool;
}

Future<bool> containsKey(String key) async {
  var pref = await SharedPreferences.getInstance();
  bool isVal = pref.containsKey(key);
  return isVal;
}

Future<void> saveString(String key, String value) async {
  var pref = await SharedPreferences.getInstance();
  pref.setString(key, value);
}
