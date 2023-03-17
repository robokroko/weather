part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsAllowed;
  const GpsState({this.isGpsAllowed = false});

  @override
  List<Object> get props => [isGpsAllowed];
}
