import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parkingapp/core/domain/model/availability.dart';
import 'package:parkingapp/features/common_ui/headings.dart';

class AvailabilitySlider extends StatelessWidget {
  final Availability availability;

  const AvailabilitySlider({Key? key, required this.availability})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: BoldHeading(text: "Зафатеност:"),
              margin: EdgeInsets.only(bottom: 10)),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: LinearProgressIndicator(
              value: availability.averageOccupancy,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              valueColor: AlwaysStoppedAnimation<Color>(
                  getAvailabilityColor(availability.averageOccupancy)),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Text(
            availability.hasEntriesToday
                ? "Ажурирано пред 24h"
                : "Типична зафатеност",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Color getAvailabilityColor (double occupancy) {
    // if (occupancy < 0.5) {
    //   return Colors.greenAccent;
    // } else if (occupancy < 0.85) {
    //   return Colors.deepOrangeAccent;
    // } else {
    //   return Colors.redAccent;
    // }
    return Color.lerp(Colors.greenAccent, Colors.deepOrange, occupancy) ?? Colors.deepOrange;
  }
}
