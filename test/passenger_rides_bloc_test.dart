import 'package:latlong/latlong.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/data/rides_repository.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:ride/rides/models/seat_entity.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

class MockRideRepo extends Mock implements LocalRepository {}

main() {
  group("ride repo", () {
    var locations = [
      RideLocation("سلف مرکزی", LatLng(0, 0)),
      RideLocation("ایستگاه اتوبوس", LatLng(1, 1)),
      RideLocation("خوابگاه", LatLng(2, 2)),
      RideLocation("میدان استقلال", LatLng(3, 3)),
      RideLocation("سبزه میدان", LatLng(3, 3)),
      RideLocation("اعتمادیه", LatLng(3, 3)),
      RideLocation("کوچه مشکی", LatLng(3, 3)),
      RideLocation("شهرک کارمندان", LatLng(3, 3)),
    ];

    var sampleRides = [
      RideEntity(locations[2], locations[6], RideTime(10, 10, 1),
          Driver("Hasan", "9991112222", Sex.MALE, 1, "11a11"), 1),
      RideEntity(locations[1], locations[7], RideTime(14, 20, 1),
          Driver("Ali", "09991112222", Sex.MALE, 2, "11b22"), 2),
      RideEntity(locations[3], locations[5], RideTime(12, 0, 1),
          Driver("Davood", "09991112222", Sex.MALE, 3, "11c33"), 3),
    ];

    MockRideRepo repo = MockRideRepo();
    when(repo.rides()).thenAnswer((_) => Future.value(sampleRides));
    PassengerRidesBloc bloc = PassengerRidesBloc(repo);

    /*repo.addRide( RideEntity(
        LatLng(3, 3),
        RideTime(18, 32, 1),
        DriverEntity("Fariborz", "09991112222", DriverSex.FEMALE, "11d44"),
        4),);*/

    test("basic reservation", () {
      bloc.reserveSeat.add(SeatReservation(SeatPosition.BACK, sampleRides[0],
          Passenger("aa", "111", Sex.MALE, 1)));

      bloc.reserveSeat.add(SeatReservation(SeatPosition.FRONT, sampleRides[0],
          Passenger("bb", "222", Sex.MALE, 2)));

      bloc.rides.listen((l) {
        print(l[0].seats.map((se) =>
            se.position.toString() +
            "  " +
            se.runtimeType.toString() +
            "  " +
            (se is TakenSeat ? (se as TakenSeat).passenger.name : "")));
      });
    });

    test("basic functionality", () {
      bloc.rides.listen((list) {
        expect(list.length, 4);
      });
    });

    test("basic filtering", () {
      var filter =
          VisibilityFilter(RideTime(13, 0, 0), RideTime(19, 0, 0), Sex.MALE);

      bloc.updateFilter.add(filter);

      bloc.rides.listen((list) {
        expect(list.first.driver.name, "Ali");
      });
    });
  });
}
