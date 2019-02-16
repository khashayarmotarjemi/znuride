import 'package:flutter/material.dart';
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/widgets/rides_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RidesList(),
      ),
    );
  }
}
