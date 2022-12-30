
// class ProfileModel {
//   int? id;
//   String? entryTime;
//   String? lastTime;
//   int? lateCountDay;
//   int? increment;
//   int? promotion;
//   String? lateAttendanceSalaryDeduct;
//   String? lat;
//   String? lng;
//   String? distance;
//   dynamic createdAt;
//   dynamic updatedAt;

//   ProfileModel({required this.id, required this.entryTime, required this.lastTime, required this.lateCountDay, required this.increment, required this.promotion, required this.lateAttendanceSalaryDeduct, required this.lat, required this.lng, required this.distance, required this.createdAt, required this.updatedAt});

//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     if(json["id"] is int) {
//       id = json["id"];
//     }
//     if(json["entry_time"] is String) {
//       entryTime = json["entry_time"];
//     }
//     if(json["last_time"] is String) {
//       lastTime = json["last_time"];
//     }
//     if(json["late_count_day"] is int) {
//       lateCountDay = json["late_count_day"];
//     }
//     if(json["increment"] is int) {
//       increment = json["increment"];
//     }
//     if(json["promotion"] is int) {
//       promotion = json["promotion"];
//     }
//     if(json["late_attendance_salary_deduct"] is String) {
//       lateAttendanceSalaryDeduct = json["late_attendance_salary_deduct"];
//     }
//     if(json["lat"] is String) {
//       lat = json["lat"];
//     }
//     if(json["lng"] is String) {
//       lng = json["lng"];
//     }
//     if(json["distance"] is String) {
//       distance = json["distance"];
//     }
//     createdAt = json["created_at"];
//     updatedAt = json["updated_at"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     _data["entry_time"] = entryTime;
//     _data["last_time"] = lastTime;
//     _data["late_count_day"] = lateCountDay;
//     _data["increment"] = increment;
//     _data["promotion"] = promotion;
//     _data["late_attendance_salary_deduct"] = lateAttendanceSalaryDeduct;
//     _data["lat"] = lat;
//     _data["lng"] = lng;
//     _data["distance"] = distance;
//     _data["created_at"] = createdAt;
//     _data["updated_at"] = updatedAt;
//     return _data;
//   }
// }

class Album {
  // final int userId;
  // final int id;
  // final String title;

  final int id;
  final String entryTime;
  final String lastTime;
  final int lateCountDay;
  final int increment;
  final int promotion;
  final String lateAttendanceSalaryDeduct;
  final String lat;
  final String lng;
  final String distance;
  final Null createdAt;
  final Null updatedAt;

  const Album({
    // required this.userId,
    // required this.id,
    // required this.title,

    required this.id,
      required this.entryTime,
      required this.lastTime,
      required this.lateCountDay,
      required this.increment,
      required this.promotion,
      required this.lateAttendanceSalaryDeduct,
      required this.lat,
      required this.lng,
      required this.distance,
      required this.createdAt,
      required this.updatedAt
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      // userId: json['userId'],
      // id: json['id'],
      // title: json['title'],


    id: json['id'],
    entryTime : json['entry_time'],
    lastTime : json['last_time'],
    lateCountDay : json['late_count_day'],
    increment : json['increment'],
    promotion : json['promotion'],
    lateAttendanceSalaryDeduct : json['late_attendance_salary_deduct'],
    lat : json['lat'],
    lng : json['lng'],
    distance : json['distance'],
    createdAt : json['created_at'],
    updatedAt : json['updated_at'],
    );
  }
}