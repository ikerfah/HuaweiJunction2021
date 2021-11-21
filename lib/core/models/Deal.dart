import 'package:HMSFlutter/core/models/Company.dart';

class Deal {
  int id;
  String title;
  String description;
  String imagePath;
  int companyId;
  String dealValidity;
  bool isExclusive;
  bool isApplied;
  int claimAmount;
  int interestId;


  Deal({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.companyId,
    required this.dealValidity,
    required this.claimAmount,
    required this.interestId,
    this.isExclusive = false,
    this.isApplied = false
  });

  String heroTag(){
    return "$id-$title";
  }
}
