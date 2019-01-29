import 'package:flutter/material.dart';
import 'package:ride/rides/ride_entity.dart';

class RideListItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final RideEntity ride;

  RideListItem({
    @required this.ride,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      );
  }
}