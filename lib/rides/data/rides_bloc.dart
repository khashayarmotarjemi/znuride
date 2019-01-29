import 'dart:async';

import 'package:ride/rides/data/rides_repository.dart';
import 'package:ride/rides/ride_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';

class RidesListBloc {
  // inputs
  final Sink<VisibilityFilter> updateFilter;

  // outputs
  final Stream<List<RideEntity>> rides;

  // cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory RidesListBloc(RidesRepository repo) {
    final subscriptions = <StreamSubscription<dynamic>>[];

    final updateFilterController = BehaviorSubject<VisibilityFilter>(
/*
      seedValue: VisibilityFilter.all,
*/
      sync: true,
    );

    final visibleRidesController = BehaviorSubject<List<RideEntity>>();

    Observable.combineLatest2<List<RideEntity>, VisibilityFilter,
        List<RideEntity>>(
      repo.todos,
      updateFilterController.stream,
      _filterRides,
    ).pipe(visibleRidesController);

    return RidesListBloc._(
      updateFilterController,
      visibleRidesController.stream,
      subscriptions,
    );
  }

  RidesListBloc._(
    this.updateFilter,
    this.rides,
    this._subscriptions,
  );

  static List<RideEntity> _filterRides(
      List<RideEntity> rides, VisibilityFilter filter) {
    return rides.where((ride) {
      switch (filter) {
      }
    }).toList();
  }

  void close() {
    updateFilter.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}

class VisibilityFilter {}
