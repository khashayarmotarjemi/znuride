import 'package:latlong/latlong.dart';
import 'package:ride/rides/models/seat_entity.dart';

class RideEntity {
  final LatLng startLocation;
  final RideTime startTime;
  final DriverEntity driver;
  final int id;
  List<SeatEntity> seats;

  RideEntity(this.startLocation, this.startTime, this.driver, this.id) {
    this.seats =[];

    seats.add(EmptySeat(id, SeatPosition.BACK));
    seats.add(EmptySeat(id, SeatPosition.BACK));
    seats.add(EmptySeat(id, SeatPosition.BACK));
    seats.add(EmptySeat(id, SeatPosition.FRONT));
  }

  bool reserveSeat(SeatPosition ps) {
    EmptySeat seat = EmptySeat(id, ps);
    if (seats.contains(seat)) {
      seats.remove(seat);
      seats.add(seat.reserve());
      return true;
    } else {
      print("empty seat doesn't exist");
      return false;
    }
  }
}

class DriverEntity {
  final String name;
  final DriverSex sex;
  final String phone;
  final String carPlate;

  DriverEntity(this.name, this.phone, this.sex, this.carPlate);
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

enum DriverSex { MALE, FEMALE }
