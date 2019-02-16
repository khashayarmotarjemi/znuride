import 'dart:async';

import 'package:ride/common/bloc.dart';
import 'package:ride/rides/data/rides_repository.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:rxdart/rxdart.dart';

class DriverRidesBloc extends Bloc {
  // inputs
  final Sink<VisibilityFilter> updateFilter;

  // outputs
  final Stream<List<RideEntity>> rides;

  // cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory DriverRidesBloc(AbstractRideRepository repo) {
    final subscriptions = <StreamSubscription<dynamic>>[];

    final updateFilterController = BehaviorSubject<VisibilityFilter>(
      seedValue: NoFilter(),
      sync: true,
    );

    final visibleRidesController =
        BehaviorSubject<List<RideEntity>>(sync: true);

    Observable.combineLatest2<List<RideEntity>, VisibilityFilter,
        List<RideEntity>>(
      repo.rides().asStream(),
      updateFilterController.stream,
      _filterRides,
    ).pipe(visibleRidesController);

    return DriverRidesBloc._(
      updateFilterController,
      visibleRidesController.stream,
      subscriptions,
    );
  }

  DriverRidesBloc._(
    this.updateFilter,
    this.rides,
    this._subscriptions, /*this.addRide,*/
  );

  static List<RideEntity> _filterRides(
      List<RideEntity> rides, VisibilityFilter filter) {
    if (filter is NoFilter) {
      return rides;
    } else {
      var list = rides.where((ride) {
        return (ride.startTime.isInRange(filter.from, filter.to) &&
            (ride.driver.sex == filter.sex));
      }).toList();
      return list;
    }
  }

  @override
  void dispose() {
    updateFilter.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}

class VisibilityFilter {
  final RideTime from;
  final RideTime to;
  final DriverSex sex;

  VisibilityFilter(this.from, this.to, this.sex);
}

class NoFilter extends VisibilityFilter {
  NoFilter() : super(RideTime(0, 0, 0), RideTime(0, 0, 0), DriverSex.FEMALE);
}
