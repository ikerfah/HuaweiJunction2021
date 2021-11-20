import 'package:huawei_map/components/latLng.dart';

class Company {
  int id;
  String name;
  String logoPath;
  double rating;
  String location;
  String phone;
  String website;
  LatLng latLng;


  Company({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.rating,
    required this.location,
    required this.phone,
    required this.website,
    required this.latLng,
  });
}
