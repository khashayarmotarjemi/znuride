import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:ride/rides/models/seat_entity.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:ride/rides/widgets/ride_list_item.dart';
import 'package:ride/user/user_bloc.dart';

class ReservationPage extends StatefulWidget {
  RideEntity _ride;

  @override
  _ReservationPageState createState() => _ReservationPageState(_ride);

  ReservationPage(this._ride);
}

class _ReservationPageState extends State<ReservationPage> {
  RideEntity _ride;
  bool showSuccess = false;

  _ReservationPageState(this._ride);

  bool hasEmpty(SeatPosition position) {
    return _ride.seats
        .where((seat) => seat is EmptySeat && seat.position == position)
        .toList()
        .isNotEmpty;
  }

  Future<bool> reserveSeat(SeatPosition position) {
    BlocProvider.of<UserBloc>(context).user.listen((user) {
      var passenger = user as Passenger;
      passenger.reserve(_ride);
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("جزییات"),
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            child: Column(
              children: <Widget>[
                RideListItem(
                  ride: _ride,
                  hiddenButton: true,
                  onTap: () {},
                ),
                new SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        new Expanded(
                          child: Container(
                            child: Center(
                              child: Container(
                                width: 150,
                                height: 150,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.airline_seat_recline_normal,
                                              size: 40,
                                              color: _ride.seats.firstWhere(
                                                          (se) =>
                                                              se.position ==
                                                              SeatPosition
                                                                  .FRONT)
                                                      is EmptySeat
                                                  ? Colors.green
                                                  : Colors.redAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 45),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.airline_seat_recline_normal,
                                              size: 40,
                                              color: _ride.seats
                                                      .where((se) =>
                                                          se.position ==
                                                          SeatPosition.BACK)
                                                      .toList()[0] is EmptySeat
                                                  ? Colors.green
                                                  : Colors.redAccent,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.airline_seat_recline_normal,
                                              size: 40,
                                              color: _ride.seats
                                                      .where((se) =>
                                                          se.position ==
                                                          SeatPosition.BACK)
                                                      .toList()[1] is EmptySeat
                                                  ? Colors.green
                                                  : Colors.redAccent,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.airline_seat_recline_normal,
                                              size: 40,
                                              color: _ride.seats
                                                      .where((se) =>
                                                          se.position ==
                                                          SeatPosition.BACK)
                                                      .toList()[2] is EmptySeat
                                                  ? Colors.green
                                                  : Colors.redAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 40),
/*
                          child: Center(child: Text("برای رزرو صندلی  \nخود را انتخاب کنید"),),
*/
                            child: Center(
                              child: hasEmpty(SeatPosition.FRONT) ||
                                      hasEmpty(SeatPosition.BACK)
                                  ? Column(
                                      children: <Widget>[
                                        hasEmpty(SeatPosition.FRONT)
                                            ? Card(
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                color: Colors.lightBlueAccent,
                                                child: FlatButton.icon(
                                                    onPressed: () {
                                                      if (hasEmpty(
                                                          SeatPosition.FRONT)) {
                                                        reserveSeat(
                                                            SeatPosition.FRONT);
                                                        print("234234234");
                                                        setState(() {
                                                          showSuccess = true;
                                                          Timer(
                                                              Duration(
                                                                  seconds: 2),
                                                              () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                        });
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.arrow_drop_up,
                                                      color: Colors.blueGrey,
                                                    ),
                                                    label: Text("صندلی جلو")),
                                              )
                                            : Container(),
                                        hasEmpty(SeatPosition.BACK)
                                            ? Card(
                                                color: Colors.greenAccent,
                                                child: FlatButton.icon(
                                                    onPressed: () {
                                                      if (hasEmpty(
                                                          SeatPosition.BACK)) {
                                                        reserveSeat(
                                                            SeatPosition.BACK);
                                                        print("234234234");
                                                        setState(() {
                                                          showSuccess = true;
                                                          Timer(
                                                              Duration(
                                                                  seconds: 2),
                                                              () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                        });
                                                      }
                                                    },
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    label: Text("صندلی عقب")),
                                              )
                                            : Container()
                                      ],
                                    )
                                  : Container(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          showSuccess
              ? new SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Container(
                    color: Color.fromARGB(180, 20, 20, 20),
                    child: Center(
                      child: Card(
                        child: Container(
                          width: 250,
                          height: 100,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text("عملیات رزرو با موفقیت انجام شد"),
                                  margin: EdgeInsets.only(top: 20, bottom: 7),
                                ),
                                Icon(Icons.thumb_up)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
