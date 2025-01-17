import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateFirstName extends RegistrationEvent {
  final String firstName;

  UpdateFirstName(this.firstName);

  @override
  List<Object?> get props => [firstName];
}

class UpdateLastName extends RegistrationEvent {
  final String lastName;

  UpdateLastName(this.lastName);

  @override
  List<Object?> get props => [lastName];
}

class UpdateEmail extends RegistrationEvent {
  final String email;

  UpdateEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdatePassword extends RegistrationEvent {
  final String password;

  UpdatePassword(this.password);

  @override
  List<Object?> get props => [password];
}

class RegistrationSubmitted extends RegistrationEvent {}
