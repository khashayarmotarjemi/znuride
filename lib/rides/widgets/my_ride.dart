import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:ride/rides/models/seat_entity.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:ride/rides/widgets/ride_list_item.dart';
import 'package:ride/user/user_bloc.dart';

class MyRide extends StatefulWidget {
  @override
  _MyRideState createState() => _MyRideState();
}

class _MyRideState extends State<MyRide> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserEntity>(
      stream: BlocProvider
          .of<UserBloc>(context)
          .user,
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData && userSnapshot.data is Passenger ) {
          var passenger = userSnapshot.data as Passenger;

          if (passenger.ride() != null) {
            return passenger.hasReserved()
                ? MyRideDetail(passenger)
                : Card(
              child: Center(
                child: Container(
                  child: Text("سفری رزرو نکرده اید"),
                  margin: EdgeInsets.all(20),
                ),
              ),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}

class MyRideDetail extends StatefulWidget {
  Passenger passenger;

  MyRideDetail(this.passenger);

  @override
  _MyRideDetailState createState() => _MyRideDetailState(passenger);
}

class _MyRideDetailState extends State<MyRideDetail> {
  Passenger passenger;

  _MyRideDetailState(this.passenger);

  Future<bool> unReserveSeat() {
    BlocProvider
        .of<UserBloc>(context)
        .user
        .listen((user) {
      var passenger = user as Passenger;
      setState(() {
        passenger.unReserve();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RideListItem(ride: passenger.ride(), hiddenButton: true),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Container(
            width: 200,
            child: new Card(
              color: Colors.red,
              child: FlatButton.icon(
                  label: Text(
                    "لغو سفر",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    unReserveSeat();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
