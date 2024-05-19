import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/core/dependency_injection/injectable_config.dart';
import 'package:parkingapp/features/common_ui/headings.dart';
import 'package:parkingapp/features/parking_payment/presentation/bloc/payment_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContributeDialog extends StatefulWidget {
  @override
  State<ContributeDialog> createState() => _ContributeDialogState();
}

class _ContributeDialogState extends State<ContributeDialog> {
  String shouldContributeForParking = "";

  @override
  void initState() {
    super.initState();
    _loadShouldContributeForParking();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text("Hi"),
      ),
    );
  }

  void _loadShouldContributeForParking() async {
    final prefs = await SharedPreferences.getInstance();
    final shouldContributeForParking = prefs.getString('shouldContributeForParking');
    if (shouldContributeForParking != null || shouldContributeForParking != "") {
      this.shouldContributeForParking = shouldContributeForParking!;
    }
  }

}
