import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/registration/registration_bloc.dart';
import 'package:test_app/blocs/registration/registration_state.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        if (state is RegistrationInitial) {
          return Center(child: Text('Initial State'));
        } else if (state is RegistrationValid) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('First Name: ${state.firstName}'),
                Text('Last Name: ${state.lastName}'),
                Text('Email: ${state.email}'),
                Text('Password: ${state.password}'),
              ],
            ),
          );
        }
        return Center(child: Text('Unknown State'));
      },
    );
  }
}
