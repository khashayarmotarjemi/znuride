import 'package:flutter/material.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:ride/rides/widgets/ride_list_item.dart';

class RidesList extends StatelessWidget {
  RidesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   /* return StreamBuilder<ContactData>(
      stream: ContactsBlocProvider.of(context).contactData,
      builder: (context, snapshot) => snapshot.hasData
          ? _buildList(snapshot.data.contacts)
          : LoadingSpinner(),
    );*/
  }

  ListView _buildList(List<RideEntity> rides) {
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
