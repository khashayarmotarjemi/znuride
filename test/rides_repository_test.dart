import 'package:latlong/latlong.dart';
import 'package:ride/rides/data/passenger_rides_bloc.dart';
import 'package:ride/rides/data/rides_repository.dart';
import 'package:ride/rides/models/ride_entity.dart';
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
      RideEntity newRide = RideEntity(locations[5], oldRide.endLocation,
          oldRide.startTime, oldRide.driver, oldRide.id);

      repo.updateRide(newRide);

      repo.rides().then((l) {
        expect(l[2].startLocation.name, locations[5].name);
      });
    });
  });
}
