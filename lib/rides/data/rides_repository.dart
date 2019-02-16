import 'package:latlong/latlong.dart';
import 'package:ride/rides/models/ride_entity.dart';

class LocalRepository extends AbstractRideRepository {
  List<RideEntity> sampleRides = [
    /*RideEntity(LatLng(0, 0), RideTime(10, 10, 1),
        DriverEntity("Hasan", "09991112222", DriverSex.MALE, "11a11"), 1),
    RideEntity(LatLng(1, 1), RideTime(14, 20, 1),
        DriverEntity("Ali", "09991112222", DriverSex.FEMALE, "11b22"), 2),
    RideEntity(LatLng(2, 2), RideTime(12, 0, 1),
        DriverEntity("Davood", "09991112222", DriverSex.MALE, "11c33"), 3),
    RideEntity(LatLng(3, 3), RideTime(18, 32, 1),
        DriverEntity("Fariborz", "09991112222", DriverSex.FEMALE, "11d44"), 4),*/
  ];

  @override
  Future<List<RideEntity>> rides() async {
    return Future.value(sampleRides);
  }

  @override
  Future<WebResponse> updateRide(RideEntity ride) {
    removeRide(ride.id).then((wr) {
      if (wr.success) {
        addRide(ride);
      } else {
        print("couldn't delete ride, so update halted");
      }
    });
  }

  @override
  Future<WebResponse> removeRide(int rideID) {
    try {
      sampleRides.removeWhere((ride) => ride.id == rideID);
      return Future.value(WebResponse(true, "successfully updated ride"));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<WebResponse> addRide(RideEntity ride) {
    if (!sampleRides.contains(ride)) {
      sampleRides.add(ride);
      return Future.value(WebResponse(true, "successfully added ride"));
    } else {
      print("couldn't add ride, already exists");
      return Future.value(WebResponse(false, "couldn't add ride"));
    }
  }
}

abstract class AbstractRideRepository {
  Future<List<RideEntity>> rides();

  Future<WebResponse> addRide(RideEntity ride);

  Future<WebResponse> removeRide(int rideID);

  Future<WebResponse> updateRide(RideEntity ride);
}

class WebResponse {
  final bool success;
  final String msg;

  WebResponse(this.success, this.msg);
}
