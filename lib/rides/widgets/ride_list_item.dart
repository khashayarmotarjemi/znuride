import 'package:flutter/material.dart';
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:ride/rides/widgets/reservation_widget.dart';
import 'package:ride/user/user_bloc.dart';

class RideListItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final RideEntity ride;
  final bool hiddenButton;

  RideListItem(
      {@required this.ride, @required this.onTap, this.hiddenButton = false});

  Widget inside(userSnapshot, context) {
    return Container(
      child: new Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 12, top: 12),
                      child: new Image.asset(
                        "assets/place_holder.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Text(ride.driver.name),
                    Card(
                      elevation: 6,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(ride.driver.carPlate),
                      ),
                    )
                  ],
                ),
                color: Colors.grey[100],
              )),
          Container(
            margin: EdgeInsets.only(top: 1, bottom: 1),
            width: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 8, right: 8),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 6, bottom: 6),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(
                          Icons.location_searching,
                          color: hiddenButton
                              ? Colors.black54
                              : Colors.deepPurpleAccent,
                        ),
                        Padding(padding: EdgeInsets.only(right: 5)),
                        Text("  :مبدا"),
                        Text(ride.startLocation.name)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6, bottom: 12),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.cyan,
                        ),
                        Padding(padding: EdgeInsets.only(right: 5)),
                        Text("  :مقصد"),
                        Text(ride.endLocation.name)
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 160,
                    color: Colors.grey[400],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(Icons.access_time),
                        Padding(padding: EdgeInsets.only(right: 12)),
                        Text(ride.startTime.hour.toString() +
                            ":" +
                            ride.startTime.minute.toString())
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          hiddenButton
              ? Container()
              : Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                handleSelect(context, userSnapshot.data),
                            child: userSnapshot.data is Passenger &&
                                    (userSnapshot.data as Passenger)
                                        .hasReserved()
                                ? Container()
                                : Card(
                                    color: Colors.grey[200],
                                    elevation: 7,
                                    margin: EdgeInsets.only(
                                        top: 35, bottom: 35, left: 5, right: 5),
                                    child: Container(
                                        width: 60,
                                        child: Column(
                                          children: <Widget>[
                                            Text("رزرو"),
                                            Icon(
                                              Icons.add_circle,
                                              color: Colors.green,
                                              size: 40,
                                            )
                                          ],
                                        )),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ), /*Expanded(
                flex: 2,
                child: Container(
                  color: Colors.red,
                ),
              )*/
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserEntity>(
        stream: BlocProvider.of<UserBloc>(context).user,
        builder: (context, userSnapshot) {
          return new SizedBox(
              width: double.infinity,
              height: 160,
              child: hiddenButton
                  ? Container(
                      child: inside(userSnapshot, context),
                    )
                  : Card(
                      child: inside(userSnapshot, context),
                      elevation: 4,
                    ));
        });
  }

  void handleSelect(BuildContext context, Passenger user) {
    if (user is Passenger) {
      if (user.hasReserved()) {
      } else {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ReservationPage(ride)));
      }
    }
  }
}

/*
Container(child: Text(ride.startTime.hour.toString() +
":" +
ride.startTime.minute.toString())));*/
