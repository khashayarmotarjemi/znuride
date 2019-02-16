abstract class SeatEntity {
  final int rideID;
  final SeatPosition position;

  SeatEntity(this.rideID, this.position);
}

class EmptySeat extends SeatEntity {
  EmptySeat(int rideID, SeatPosition position) : super(rideID, position);

  TakenSeat reserve() {
    return TakenSeat(rideID, position);
  }
}

class TakenSeat extends SeatEntity {
  TakenSeat(int rideID, SeatPosition position) : super(rideID, position);

  EmptySeat unReserve() {
    return EmptySeat(rideID, position);
  }
}

enum SeatPosition { FRONT, BACK1, BACK2, BACK3 }
