import 'dart:async';
import 'dart:convert';

import 'package:attendance_limtech/model/profileModel.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:attendance_limtech/response/userResponse.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool servicestatus = false;
  bool haspermission = false;
  bool checkIn = true;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  Map<String, dynamic> attendanceStutas = {};
  late int userID;
  String currentLat = "", currentLng = "", distance = "";

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    //print(servicestatus);
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          //print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          //print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
      //print("if");
    } else {
      //print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    //print("sdasd");
    double distanceDifferent = 1000 * 12742 * asin(sqrt(a));
    distance = distanceDifferent.toString();
    currentLat = lat2.toString();
    currentLng = lat2.toString();
    // //print(attendanceStutas);
    return distanceDifferent;
  }

  postData() async {
    String token = "84|KIje4erJ8FdbK2kjB5Aucy0e4voI5MIn3lPz3YCR";
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token1 = pref.getString("token");
    String token3 = token1.toString();

    
    print("post $token3");
    final response = await http.post(
      Uri.parse(
          'https://erp.ldlerp.com/backend/public/api/attendance-app-save'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token3',
      },
      body: {
        // "user_id": userID.toString(),
        "lat": currentLat,
        "lng": currentLng,
        "distance": distance
      },
    );
    print("id");
    print(userID.toString());
    // Attendance
    var data = json.decode(response.body);
    print(data['message']);
    toast(data['message']);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(data['message']),
    // ));
  }

  toast(data) {
   if(data.compareTo("Attendance Successfully Inserted!!")==0){
     MotionToast(
      icon: Icons.add_reaction,
      // color: ,
      // title: Text("Error!!"),
      description: Text(data),
      position: MotionToastPosition.center,
      animationType: AnimationType.fromTop, primaryColor: Colors.green,
    ).show(context);
   }
   else{

    MotionToast(
      icon: Icons.add_reaction,
      // color: ,
      // title: Text("Error!!"),
      description: Text(data),
      position: MotionToastPosition.center,
      animationType: AnimationType.fromTop, primaryColor: Colors.red,
    ).show(context);

   }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      // onPrimary: Colors.black87,
      // primary: Colors.grey[300],
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return FutureBuilder<Album>(
      future: UserResponse().fetchAlbum(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Album data = snapshot.hasData!;
          userID = snapshot.data!.id;
          print(snapshot.data!.id);
          return Center(
            child: ElevatedButton(
              // style: raisedButtonStyle,
              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 2.5, color: Colors.white),
                primary: Colors.green,
                // onPrimary: index == 0 ? Colors.white : Colors.black,
                textStyle: const TextStyle(
                  fontSize: 15,
                ),
              ),
              // onPressed: postData(snapshot.data!.lat, snapshot.data!.lng) , //() {
              onPressed: () {
                var lat2 = double.parse(snapshot.data!.lat);
                var lng2 = double.parse(snapshot.data!.lng);

                var lat1 = double.parse(lat);
                var lng1 = double.parse(long);
                // // postData1(lat2, lng2);

                calculateDistance(lat1, lng1, lat2, lng2);
                // checkIn = !checkIn;
                postData();
              },
              // child: const Text(
              //   'Attendance',
              //   style: TextStyle(fontSize: 50),
              // ),
              child: Icon(Icons.check_outlined,color: Colors.white,size: 100),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
