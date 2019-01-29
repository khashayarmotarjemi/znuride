import 'package:latlong/latlong.dart';
import 'package:ride/rides/models/ride_entity.dart';

class RidesRepository {
  Future<List<RideEntity>> rides() async {
    return Future.delayed(
        Duration(seconds: 2),
        () => [
              RideEntity(
                  LatLng(0, 0),
                  RideTime(10, 10, 1),
                  DriverEntity(
                      "Hasan", "09991112222", DriverSex.MALE, "11a11")),
              RideEntity(
                  LatLng(1, 1),
                  RideTime(14, 20, 1),
                  DriverEntity(
                      "Ali", "09991112222", DriverSex.FEMALE, "11b22")),
              RideEntity(
                  LatLng(2, 2),
                  RideTime(12, 0, 1),
                  DriverEntity(
                      "Davood", "09991112222", DriverSex.MALE, "11c33")),
              RideEntity(
                  LatLng(3, 3),
                  RideTime(18, 32, 1),
                  DriverEntity(
                      "Fariborz", "09991112222", DriverSex.FEMALE, "11d44")),
            ]);
  }
}
