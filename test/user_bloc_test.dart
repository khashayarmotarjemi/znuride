import 'package:latlong/latlong.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/data/rides_repository.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:ride/rides/models/seat_entity.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:ride/user/user_bloc.dart';
import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

main() {
  group("user repo", () {
    UserBloc bloc = UserBloc();

    test("basic login", () {
      bloc.logUserIn.add(Passenger("khashayar", "099", Sex.MALE, 44));
      bloc.isLoggedIn.listen((bool) => expect(bool, true));
      bloc.user.listen((user) => expect(user.name, "khashayar"));
    });
  });
}
