import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/common/login_screen.dart';
import 'package:ride/home/home_screen.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/data/rides_repository.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:ride/user/user_bloc.dart';

var ridesRepo = LocalRepository();

void main() {
  var locations = [
    RideLocation("سلف مرکزی", LatLng(0, 0)),
    RideLocation("ایستگاه اتوبوس", LatLng(1, 1)),
    RideLocation("خوابگاه", LatLng(2, 2)),
    RideLocation("میدان استقلال", LatLng(3, 3)),
    RideLocation("سبزه میدان", LatLng(3, 3)),
    RideLocation("اعتمادیه", LatLng(3, 3)),
    RideLocation("کوچه مشکی", LatLng(3, 3)),
    RideLocation("شهرک کارمندان", LatLng(3, 3)),
  ];

  var sampleRides = [
    RideEntity(locations[2], locations[6], RideTime(10, 10, 1),
        Driver("Hasan", "9991112222", Sex.MALE, 1, "11a11"), 1),
    RideEntity(locations[1], locations[7], RideTime(14, 20, 1),
        Driver("Ali", "09991112222", Sex.MALE, 2, "11b22"), 2),
    RideEntity(locations[3], locations[5], RideTime(12, 0, 1),
        Driver("Davood", "09991112222", Sex.MALE, 3, "11c33"), 3),
    RideEntity(locations[2], locations[4], RideTime(18, 32, 1),
        Driver("Fariborz", "09991112222", Sex.FEMALE, 4, "11d44"), 4)
  ];

  sampleRides.forEach((re) => ridesRepo.addRide(re));

  runApp(BlocProvider<PassengerRidesBloc>(
    bloc: PassengerRidesBloc(ridesRepo),
    child: BlocProvider<UserBloc>(
      bloc: UserBloc(),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZNU Ride',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
//        '/': (context) => HomeScreen(),
        '/': (context) => LoginScreen()
      },
    );
  }
}
