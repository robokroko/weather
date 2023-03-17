import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super(const GpsState()) {
    on<ChangeGpsStateToTurnedOn>(
        (ChangeGpsStateToTurnedOn event, Emitter<GpsState> emit) {
      emit(
        const GpsState(isGpsAllowed: true),
      );
    });

    on<ChangeGpsStateToTurnedOff>(
        (ChangeGpsStateToTurnedOff event, Emitter<GpsState> emit) {
      emit(
        const GpsState(isGpsAllowed: false),
      );
    });
  }
}
