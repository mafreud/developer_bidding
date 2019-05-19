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
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(27.0),
            child:
                Icon(Icons.check_circle, color: easyFundMainColor, size: 20.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '業務スーパー奨学金',
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                ),
                Text('¥1,200,000'),
                Text(
                  '9月18日締め切り',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(width: 60.0),
          Icon(
            Icons.keyboard_arrow_right,
            color: easyFundMainColor,
            size: 30.0,
          ),
        ],
      ),
      elevation: 5.0,
      color: Colors.white,
    );
  }
}
