import 'package:ride/rides/models/ride_entity.dart';

abstract class UserEntity {
  final String name;
  final Sex sex;
  final String phone;
  final int id;

  UserEntity(this.name, this.phone, this.sex, this.id);
}

enum Sex { MALE, FEMALE }

class Driver extends UserEntity {
  final String carPlate;

  Driver(name, phone, sex, id, this.carPlate) : super(name, phone, sex, id);
}

class Passenger extends UserEntity {
  RideEntity _reservedRide;

  bool hasReserved() {
    return _reservedRide != null;
  }

  bool reserve(RideEntity ride) {
    if (!hasReserved()) {
      _reservedRide = ride;
      return true;
    } else {
      print("user already has a ride");
      return false;
    }
  }

  bool unReserve() {

    if(hasReserved()) {
      print("unreserve");
      _reservedRide = null;
      return true;
    } else {
      print("user hasn't reserved");
      return false;
    }
  }

  RideEntity ride() {
    if(hasReserved()) {
      return _reservedRide;
    } else {
      return null;
    }
  }

  Passenger(name, phone, sex, id) : super(name, phone, sex, id);
}
