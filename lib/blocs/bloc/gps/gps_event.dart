part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();
}

class ChangeGpsStateToTurnedOn extends GpsEvent {
  @override
  List<Object> get props => [];
}

class ChangeGpsStateToTurnedOff extends GpsEvent {
  @override
  List<Object> get props => [];
}
