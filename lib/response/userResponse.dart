import 'dart:convert';

import 'package:attendance_limtech/loginPage.dart';
import 'package:attendance_limtech/model/profileModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserResponse {
  // var getToken;

  // UserResponse(this.getToken);
  final storage = new FlutterSecureStorage();

  late SharedPreferences sharedPreferences;

  Future<Album> fetchAlbum() async {
    // String token = await Candidate().getToken();
    // String token1 = LoginPage.getTokenFromSF();
    // String token = LoginPage.getToken();
    // print(token1.runtimeType);
    // print(token1);
    // String token = SharedPreferences.getString()
    Future<String?> getToken() async {
      // String? value = await storage.read(key: "token");
      return await storage.read(key: "token");
      // return tokenValue;
    }

    // print(getToken());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    String token3 = token.toString();
    print(token3);
    String token2 = "194|6tZC5OQedepPaiEBTQQpr3CbqVvVCRbjDY8K2gkc";

    // var ans = token1;
    // print(token1.runtimeType);
    // print("sadasdasdasd $ans ");
    // print("token1  $ans");
    // print(getTokenFromSF().toString());

    final response = await http.get(
        Uri.parse('https://erp.ldlerp.com/backend/public/api/setting'),
        headers: {
          'Authorization': 'Bearer 84|KIje4erJ8FdbK2kjB5Aucy0e4voI5MIn3lPz3YCR',
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(Album.fromJson(jsonDecode(response.body)));
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // print("token");
      throw Exception('Failed to load album');
    }
  }
}
