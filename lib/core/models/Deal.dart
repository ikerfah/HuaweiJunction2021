import 'package:HMSFlutter/core/models/Company.dart';

class Deal {
  int id;
  String title;
  String description;
  String imagePath;
  Company company;
  String dealValidity;
  bool isExclusive;


  Deal({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.company,
    required this.dealValidity,
    this.isExclusive = false
  });

  String heroTag(){
    return "$id-$title";
  }
}
