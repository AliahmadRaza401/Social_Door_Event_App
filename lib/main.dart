import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Providers/dataProvider.dart';
import 'Screens/Splash/splash.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(
        //   value: AuthProvider(),
        // ),
        ChangeNotifierProvider<DataProvider>(create: (BuildContext context) {
          return DataProvider();
        }),
      ],
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.orange,
        theme: ThemeData(
          // Define the default brightness and colors.
          // brightness: Brightness.light,
          primaryColor: Color(0xffff5018),
          accentColor: Color(0xffff5018),

          // // Define the default font family.
          // fontFamily: 'Georgia',
          //
          // // Define the default TextTheme. Use this to specify the default
          // // text styling for headlines, titles, bodies of text, and more.
          // textTheme: TextTheme(
          //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        home: Splash(),
      ),
    );
  }
}
