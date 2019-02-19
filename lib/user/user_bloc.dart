import 'dart:async';

import 'package:ride/common/bloc.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends Bloc {
  // inputs
  final Sink<UserEntity> logUserIn;
  final Sink<void> logUserOut;

  // outputs
  final Stream<UserEntity> user;
  final Stream<bool> isLoggedIn;

  // cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory UserBloc() {
    final logingController = StreamController<UserEntity>(
      sync: true,
    );

    final logoutController = StreamController<void>(
      sync: true,
    );

    final userController =
        BehaviorSubject<UserEntity>(sync: true, seedValue: null);

    final isLoggedInController =
        BehaviorSubject<bool>(sync: true, seedValue: false);

    final subscriptions = <StreamSubscription<dynamic>>[
      logingController.stream.listen((user) {
        userController.sink.add(user);
        isLoggedInController.sink.add(true);
      }),
      logoutController.stream.listen((v) {
        userController.sink.add(null);
        isLoggedInController.sink.add(false);
      })
    ];

    return UserBloc._(logingController.sink, logoutController.sink,
        userController.stream, isLoggedInController.stream, subscriptions);
  }

  UserBloc._(
    this.logUserIn,
    this.logUserOut,
    this.user,
    this.isLoggedIn,
    this._subscriptions,
  );

  @override
  void dispose() {
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}
