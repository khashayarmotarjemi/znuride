import 'package:flutter/material.dart';
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:ride/rides/widgets/my_ride.dart';
import 'package:ride/rides/widgets/rides_list.dart';
import 'package:ride/user/user_bloc.dart';

class PassengerHome extends StatefulWidget {
  @override
  PassengerHomeState createState() {
    return PassengerHomeState();
  }
}

class PassengerHomeState extends State<PassengerHome> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        child: Text("سفرهای موجود"),
        padding: EdgeInsets.only(left: 55),
      )),
      body: _currentIndex == 1 ? MyRide() : RidesList(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('سفرها')),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), title: Text('سفر من')),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.lightBlueAccent,
        onTap: _itemTapped,
      ),
    );
  }

  void _itemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
