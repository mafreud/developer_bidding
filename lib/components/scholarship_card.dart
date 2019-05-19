import 'package:flutter/material.dart';
import 'colors.dart';

class ScholarshipCard extends StatelessWidget {
  ScholarshipCard({this.budged, this.deadline, this.scholarshipName});

  String scholarshipName;
  DateTime deadline;
  int budged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('業務スーパー奨学金'),
          Text('申し込み期限：09/18/2019'),
          Text('提供額:400万')
        ],
      ),
      elevation: 5.0,
      color: Colors.white,
    );
  }
}
