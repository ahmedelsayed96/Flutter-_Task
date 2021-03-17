import 'package:floor/floor.dart';

@entity
class Person {
  @PrimaryKey(autoGenerate: true)
  int id;

  String imei;

  String firstName;

  String lastName;

  String birthOfDate;

  String email;

  String passport;

  String image;

  double latitute;

  double longitude;

  String deviceName;

  Person(this.imei, this.firstName, this.lastName, this.birthOfDate, this.email,
      this.passport, this.image);
}
