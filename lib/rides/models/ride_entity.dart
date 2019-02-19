import 'package:latlong/latlong.dart';
import 'package:ride/rides/models/seat_entity.dart';
import 'package:ride/rides/models/user_entity.dart';

class RideEntity {
  final RideLocation startLocation;
  final RideLocation endLocation;
  final RideTime startTime;
  final Driver driver;
  final int id;
  List<SeatEntity> seats;

  RideEntity(this.startLocation, this.endLocation, this.startTime, this.driver,
      this.id) {
    this.seats = [];

    seats.add(EmptySeat(id, SeatPosition.BACK));
    seats.add(TakenSeat(
        id, SeatPosition.BACK, Passenger("aslkdjf", "234", Sex.MALE, 12)));
    seats.add(EmptySeat(id, SeatPosition.BACK));
    seats.add(EmptySeat(id, SeatPosition.FRONT));
  }

  bool reserveSeat(Passenger passenger, SeatPosition ps) {
    EmptySeat seat = EmptySeat(id, ps);
    if (seats.contains(seat)) {
      seats.remove(seat);
      seats.add(seat.reserve(passenger));
      return true;
    } else {
      print("empty seat doesn't exist");
      return false;
    }
  }
}

class RideTime {
  final int hour;
  final int minute;
  final int day;

  RideTime(this.hour, this.minute, this.day);

  bool isInRange(RideTime from, RideTime to) {
    if (this.hour < from.hour || this.hour > to.hour) {
      return false;
    } else if (this.hour == from.hour) {
      return this.minute >= from.minute;
    } else if (this.hour == to.hour) {
      return this.minute <= to.minute;
    } else {
      return true;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideTime &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute &&
          day == other.day;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode ^ day.hashCode;
}

class RideLocation {
  final String name;
  final LatLng location;

  RideLocation(this.name, this.location);
}
