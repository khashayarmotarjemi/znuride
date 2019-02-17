import 'dart:async';

import 'package:ride/common/bloc.dart';
import 'package:ride/rides/data/rides_repository.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:ride/rides/models/seat_entity.dart';
import 'package:rxdart/rxdart.dart';

class PassengerRidesBloc extends Bloc {
  // inputs
  final Sink<VisibilityFilter> updateFilter;
  final Sink<SeatReservation> reserveSeat;

  // outputs
  final Stream<List<RideEntity>> rides;

  // cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory PassengerRidesBloc(AbstractRideRepository repo) {
    final updateFilterController = BehaviorSubject<VisibilityFilter>(
      seedValue: NoFilter(),
      sync: true,
    );

    final reservationController = StreamController<SeatReservation>(sync: true);

    final visibleRidesController =
        BehaviorSubject<List<RideEntity>>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      reservationController.stream.listen((rsrv) {
        rsrv.ride.reserveSeat(rsrv.position);
      }),
    ];

    Observable.combineLatest2<List<RideEntity>, VisibilityFilter,
        List<RideEntity>>(
      repo.rides().asStream(),
      updateFilterController.stream,
      _filterRides,
    ).pipe(visibleRidesController);

    return PassengerRidesBloc._(
      updateFilterController,
      visibleRidesController.stream,
      reservationController,
      subscriptions,
    );
  }

  PassengerRidesBloc._(
    this.updateFilter,
    this.rides,
    this.reserveSeat,
    this._subscriptions,
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
