import 'package:latlong/latlong.dart';
import 'package:ride/rides/data/rides_bloc.dart';
import 'package:ride/rides/data/rides_repository.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

class MockRideRepo extends Mock implements RidesRepository {}

main() {
  group("ride repo", () {
    var sampleRides = [
      RideEntity(LatLng(0, 0), RideTime(10, 10, 1),
          DriverEntity("Hasan", "09991112222", DriverSex.MALE, "11a11")),
      RideEntity(LatLng(1, 1), RideTime(14, 20, 1),
          DriverEntity("Ali", "09991112222", DriverSex.MALE, "11b22")),
      RideEntity(LatLng(2, 2), RideTime(12, 0, 1),
          DriverEntity("Davood", "09991112222", DriverSex.MALE, "11c33")),
      RideEntity(LatLng(3, 3), RideTime(18, 32, 1),
          DriverEntity("Fariborz", "09991112222", DriverSex.FEMALE, "11d44")),
    ];

    MockRideRepo repo = MockRideRepo();
    when(repo.rides()).thenAnswer((_) => Future.value(sampleRides));
    RidesListBloc bloc = RidesListBloc(repo);

    test("basic functionality", () {

      bloc.rides.listen((list) {
        expect(list.length, 4);
      });
    });

    test("basic filtering", () {
      var filter = VisibilityFilter(
          RideTime(13, 0, 0), RideTime(19, 0, 0), DriverSex.MALE);

      bloc.updateFilter.add(filter);


      bloc.rides.listen((list) {
        expect(list.first.driver.name,"Ali");
      });
    });
  });
}
