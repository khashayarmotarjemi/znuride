import 'package:latlong/latlong.dart';
import 'package:ride/rides/models/seat_entity.dart';

class RideEntity {
  final LatLng startLocation;
  final RideTime startTime;
  final DriverEntity driver;
  final int id;
  List<SeatEntity> _seats;

  RideEntity(this.startLocation, this.startTime, this.driver, this.id) {
    this._seats = [
      EmptySeat(id, SeatPosition.BACK1),
      EmptySeat(id, SeatPosition.BACK2),
      EmptySeat(id, SeatPosition.BACK3),
      EmptySeat(id, SeatPosition.FRONT)
    ];
  }

  TakenSeat reserveSeat(SeatPosition position) {
    final EmptySeat seat =
        _seats.firstWhere((seat) => seat.position == position);
    if (seat != null) {
      return seat.reserve();
    } else {
      throw Exception("seat shouldn't be null");
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
