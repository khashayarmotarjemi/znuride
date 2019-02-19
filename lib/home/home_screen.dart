import 'package:flutter/material.dart';
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/home/driver_home.dart';
import 'package:ride/home/passenger_home.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:ride/rides/widgets/rides_list.dart';
import 'package:ride/user/user_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<UserEntity>(
            stream: BlocProvider.of<UserBloc>(context).user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data is Driver ? DriverHome() : PassengerHome();
              } else {
                print("went to homescreen without logging in");
              }
            }),
      ),
    );
  }
}
