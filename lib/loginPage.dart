import 'dart:convert';

import 'package:attendance_limtech/main.dart';
import 'package:attendance_limtech/response/userResponse.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

  // static String getToken() {}

}

class _LoginPageState extends State<LoginPage> {
  String _errorMessage = '';
  bool _isLoading = false;

  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          //color: Theme.of(context).primaryColor,
          image: DecorationImage(
              image: AssetImage('assets/images/app_background.png'),
              fit: BoxFit.fill),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var jsonResponse = null;
    var response = await http.post(
        Uri.parse('https://erp.ldlerp.com/backend/public/api/login'),
        body: data);
    toast(json.decode(response.body));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("login $jsonResponse['token']");
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
    // print(sharedPreferences);
  }

  toast(jsonResponse) {
    if (jsonResponse['status'] == false) {
      MotionToast(
        icon: Icons.no_encryption_gmailerrorred,
        // color: ,
        title: Text("Error!!"),
        description: Text(jsonResponse['message']),
        position: MotionToastPosition.top,
        animationType: AnimationType.fromTop, primaryColor: Colors.deepOrange,
      ).show(context);
    } else {
      MotionToast(
        // icon: Icons.no_encryption_gmailerrorred,
        // color: ,
        // title: Text("Error!!"),
        description: Text(jsonResponse['message']),
        position: MotionToastPosition.top,
        animationType: AnimationType.fromTop,
        primaryColor: Color.fromARGB(255, 34, 255, 49),
      ).show(context);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: const EdgeInsets.only(left: 100, right: 100),
      margin: EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
        onPressed: () {
          signIn(emailController.text, passwordController.text);
          // _isLoading = true;
          // setState(() {
          //   _isLoading = false;
          // });

          // print("response");

          // Navigator.of(context).pushAndRemoveUntil(
          //   MaterialPageRoute(builder: (BuildContext context) => MainPage()),
          //   (Route<dynamic> route) => false);
        },
        child: const Text('Log In'),
        style: ElevatedButton.styleFrom(
          primary: Colors.orange, // Background color
        ),
      ),
    );
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          // TextFormField(
          //   controller: emailController,
          //   cursorColor: Colors.white,
          //   style: TextStyle(color: Colors.white70),
          //   decoration: InputDecoration(
          //     icon: Icon(Icons.email, color: Colors.white70),
          //     hintText: "Email",
          //     border: UnderlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white70)),
          //     hintStyle: TextStyle(color: Colors.white70),
          //   ),
          // ),
          SizedBox(height: 30.0),
          // TextFormField(
          //   controller: passwordController,
          //   cursorColor: Colors.white,
          //   obscureText: true,
          //   style: TextStyle(color: Colors.white70),
          //   decoration: InputDecoration(
          //     icon: Icon(Icons.lock, color: Colors.white70),
          //     hintText: "Password",
          //     border: UnderlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white70)),
          //     hintStyle: TextStyle(color: Colors.white70),
          //   ),
          // ),

          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 35, right: 35, bottom: 10),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      // child: Padding(
                      //   padding: const EdgeInsets.only(left: 12.0),
                      //   child: TextFormField(

                      //     textAlignVertical: TextAlignVertical.center,
                      //     cursorColor: Colors.black,
                      //     decoration: InputDecoration(
                      //       hintText: 'Please enter your password',
                      //       border: InputBorder.none,
                      //       // hintStyle: Theme.of(context)
                      //       //     .textTheme
                      //       //     .subtitle
                      //       //     .merge(TextStyle(color: Colors.grey)),
                      //     ),
                      //   ),
                      // ),
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        onChanged: (val) {
                          validateEmail(val);
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.black),
                          hintText: "Email",
                          // border: UnderlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.white)),
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 94, 93, 93)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 35, right: 35, bottom: 10),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      // child: Padding(
                      //   padding: const EdgeInsets.only(left: 12.0),
                      //   child: TextFormField(

                      //     textAlignVertical: TextAlignVertical.center,
                      //     cursorColor: Colors.black,
                      //     decoration: InputDecoration(
                      //       hintText: 'Please enter your password',
                      //       border: InputBorder.none,
                      //       // hintStyle: Theme.of(context)
                      //       //     .textTheme
                      //       //     .subtitle
                      //       //     .merge(TextStyle(color: Colors.grey)),
                      //     ),
                      //   ),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.black,
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.black),
                            hintText: "Password",
                            // border: UnderlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.white70)),
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 94, 93, 93)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
        margin: EdgeInsets.only(top: 50.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Center(
          child: Text("Limtech",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold)),
        ));
  }
}
