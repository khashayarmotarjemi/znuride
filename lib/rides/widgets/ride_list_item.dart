import 'package:flutter/material.dart';
import 'package:ride/rides/models/ride_entity.dart';

class RideListItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final RideEntity ride;

  RideListItem({
    @required this.ride,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 110,
        child:Card() );
  }
}


/*
Container(child: Text(ride.startTime.hour.toString() +
":" +
ride.startTime.minute.toString())));*/
