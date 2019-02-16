import 'package:latlong/latlong.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/data/rides_repository.dart';
import 'package:ride/rides/models/ride_entity.dart';
import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

class MockRideRepo extends Mock implements LocalRepository {}

main() {
  group("ride repo", () {
    var sampleRides = [
      RideEntity(LatLng(0, 5), RideTime(10, 10, 1),
          DriverEntity("Hasan", "09991112222", DriverSex.MALE, "11a11"), 1),
      RideEntity(LatLng(1, 5), RideTime(14, 20, 1),
          DriverEntity("Ali", "09991112222", DriverSex.MALE, "11b22"), 2),
      RideEntity(LatLng(2, 5), RideTime(12, 0, 1),
          DriverEntity("Davood", "09991112222", DriverSex.MALE, "11c33"), 3),
    ];

    LocalRepository repo = LocalRepository();

    sampleRides.forEach((r) => repo.addRide(r));

    test("adding and getting", () {
      repo.rides().then((l) {
        expect(l.length, 3);
      });
    });

    test("removing", () {
      repo.removeRide(1);

      repo.rides().then((l) {
        expect(l.length, 2);
      });
    });

    test("updating", () {
      RideEntity oldRide = sampleRides[1];
      RideEntity newRide = RideEntity(
          LatLng(2, 2), oldRide.startTime, oldRide.driver, oldRide.id);

      repo.updateRide(newRide);

      repo.rides().then((l) {
        expect(l[1].startLocation, LatLng(2,2));
      });
    });
  });
}
