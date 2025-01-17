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
    on<UpdatePassword>(
        (event, emit) => _updateState(emit, password: event.password));
  }

  void _updateState(
    Emitter<RegistrationState> emit, {
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) {
    final currentState = state;

    if (currentState is RegistrationValid) {
      emit(currentState.copyWith(
        firstName: firstName ?? currentState.firstName,
        lastName: lastName ?? currentState.lastName,
        email: email ?? currentState.email,
        password: password ?? currentState.password,
      ));
    } else {
      emit(RegistrationValid(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        email: email ?? '',
        password: password ?? '',
      ));
    }
  }
}
