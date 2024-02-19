import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class DataModel extends HiveObject {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? dob ;

  @HiveField(2)
  final String? phone;

  @HiveField(3)
  final String? expLevel;

  @HiveField(4)
  final String? gender;

  @HiveField(5)
  final bool? confirmation;

  DataModel({this.name, this.dob, this.phone, this.expLevel, this.gender, this.confirmation});
}