import 'dart:io';

import 'package:attendance_limtech/loginPage.dart';
import 'package:attendance_limtech/screen/location_page.dart';
// import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      // theme: ThemeData(
      //     colorScheme:
      //         ColorScheme.fromSwatch().copyWith(secondary: Colors.white70)),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late SharedPreferences sharedPreferences;


  




  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.blueAccent;
    return Scaffold(
      appBar: AppBar(
        // title: Text("Code Land", style: TextStyle(color: Colors.white)),
        // ignore: prefer_const_constructors
        
        // flexibleSpace: Image(
        //   image: AssetImage(' assets/images/navBar.png'),
        //   fit: BoxFit.fill,
        // ),
        backgroundColor: primaryColor,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons'),size: 50,color: Colors.red[200]),
          ),
        ],
      ),
      body: const LocationPage(),
      // drawer: Drawer(),
    );
  }
}
