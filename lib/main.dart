import 'package:flutter/material.dart';
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/home/home_screen.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/data/rides_repository.dart';

var ridesRepo = LocalRepository();

void main() => runApp(BlocProvider<PassengerRidesBloc>(
      bloc: PassengerRidesBloc(ridesRepo),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZNU Ride',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      routes: {'/': (context) => HomeScreen()},
    );
  }
}
