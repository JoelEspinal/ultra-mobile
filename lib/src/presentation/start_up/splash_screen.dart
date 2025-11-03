import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'start_up_cubit.dart';
import 'start_up_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<StartupCubit>()..syncTodos(),
      child: BlocListener<StartupCubit, StartupState>(
        listener: (context, state) {
          if (state.status == StartupStatus.success) {
            // Sync is done, go to the main app screen
            Navigator.of(context).pushReplacementNamed('/home');
          }

          if (state.status == StartupStatus.failure) {
            // Sync failed, show an error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(state.errorMessage ?? 'An unknown error occurred'),
              ),
            );
          }
        },
        child: const Scaffold(
          // Show a loading indicator while the sync is in progress
          body: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.account_circle_outlined,
                ),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
