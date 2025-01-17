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
  final String password;

  RegistrationValid({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  RegistrationValid copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) {
    return RegistrationValid(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, email, password];
}
