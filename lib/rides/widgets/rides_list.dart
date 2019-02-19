import 'package:flutter/material.dart';
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:ride/rides/widgets/ride_list_item.dart';

class RidesList extends StatelessWidget {
  RidesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RideEntity>>(
      stream: BlocProvider.of<PassengerRidesBloc>(context).rides,
      builder: (context, snapshot) => snapshot.hasData
          ? _buildList(snapshot.data)
          : Container( width: 200, height: 200),
    );
  }

  ListView _buildList(List<RideEntity> rides) {
    print("rides:" + rides.length.toString());
    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (BuildContext context, int index) {
        final ride = rides[index];

        return RideListItem(
          ride: ride,
          onTap: () {},
        );
      },
    );
  }
}
