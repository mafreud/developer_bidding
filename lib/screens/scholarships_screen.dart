import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/components/scholarship_card.dart';
import 'package:easy_fund/components/constants.dart';

class ScholarshipsScreen extends StatefulWidget {
  @override
  _ScholarshipsScreenState createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends State<ScholarshipsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('奨学金リスト'),
        backgroundColor: kEasyFundMainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                '応募可能な奨学金が５件見つかりました。',
                style: kBoldTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            ScholarshipCard(),
            ScholarshipCard(),
            ScholarshipCard(),
            ScholarshipCard(),
            ScholarshipCard(),
          ],
        ),
      ),
    );
  }
}
