import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quarty_mall_club/utils/commons.dart';
import 'package:quarty_mall_club/screens/onBoarding/onboarding_screen.dart';
import 'package:quarty_mall_club/string_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Квартимолл клуб',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFF85564, Utils.primarySwatchColor),
        indicatorColor: Utils.getPrimaryColor(),
        inputDecorationTheme: InputDecorationTheme(contentPadding: EdgeInsets.only(bottom: 0)),
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(elevation: 0, color: Colors.white),
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SharedPreferences.getInstance().then((sp) {
        if (sp.getString(KEY_USER_TOKEN) == null) {
          //TODO : put a timer to let the time to the user to see the splash screen
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => Onboarding()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/pictures/splash_big.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
