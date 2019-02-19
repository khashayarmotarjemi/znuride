import 'package:ride/rides/models/ride_entity.dart';
import 'package:quiver/core.dart';
import 'package:ride/rides/models/user_entity.dart';

abstract class SeatEntity {
  final int rideID;
  final SeatPosition position;

  SeatEntity(this.rideID, this.position);

  @override
  bool operator ==(other) {
    return this.runtimeType == other.runtimeType &&
        other is SeatEntity &&
        this.rideID == other.rideID &&
        this.position == other.position;
  }

  @override
  int get hashCode {
    return hash2(rideID, position);
  }
}

class EmptySeat extends SeatEntity {
  EmptySeat(int rideID, SeatPosition position) : super(rideID, position);

  TakenSeat reserve(Passenger passenger) {
    return TakenSeat(rideID, position, passenger);
  }
}

class TakenSeat extends SeatEntity {
  final Passenger passenger;

  TakenSeat(int rideID, SeatPosition position, this.passenger)
      : super(rideID, position);

  EmptySeat unReserve() {
    return EmptySeat(rideID, position);
  }
}

class SeatReservation extends SeatEntity {
  final RideEntity ride;
  final Passenger passenger;

  SeatReservation(SeatPosition position, this.ride, this.passenger) : super(ride.id, position);
}

enum SeatPosition { FRONT, BACK }
