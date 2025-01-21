import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/registration/registration_event.dart';
import 'package:test_app/blocs/registration/registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<UpdateFirstName>(
        (event, emit) => _updateState(emit, firstName: event.firstName));
    on<UpdateLastName>(
        (event, emit) => _updateState(emit, lastName: event.lastName));
    on<UpdateEmail>((event, emit) => _updateState(emit, email: event.email));
  }

  void _updateState(
    Emitter<RegistrationState> emit, {
    String? firstName,
    String? lastName,
    String? email,
  }) {
    final currentState = state;

    if (currentState is RegistrationValid) {
      emit(currentState.copyWith(
        firstName: firstName ?? currentState.firstName,
        lastName: lastName ?? currentState.lastName,
        email: email ?? currentState.email,
      ));
    } else {
      emit(RegistrationValid(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        email: email ?? '',
      ));
    }
  }
}
