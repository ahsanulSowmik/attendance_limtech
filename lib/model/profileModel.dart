
class Album {

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