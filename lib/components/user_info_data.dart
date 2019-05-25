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

  UserInfoData.fromSnapshotData(DocumentSnapshot snapshot)
      : name = snapshot['firstName'],
        gpa = snapshot['GPA'],
        major = snapshot['major'],
        gender = snapshot['gender'],
        grade = snapshot['grade'],
        graduationYear = snapshot['icuId'],
        email = snapshot['userEmail'],
        chatIds = snapshot['chatId']
  ;
}