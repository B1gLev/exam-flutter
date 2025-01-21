import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationValid extends RegistrationState {
  final String firstName;
  final String lastName;
  final String email;

  RegistrationValid({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  RegistrationValid copyWith({
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return RegistrationValid(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, email];
}
