import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoData{

  UserInfoData({this.name,this.gpa, this.grade, this.major, this.gender, this.chatIds, this.email, this.graduationYear });

  String name;
  double gpa;
  String major;
  String gender;
  String grade;
  List<String> chatIds;
  String email;
  int graduationYear;
}