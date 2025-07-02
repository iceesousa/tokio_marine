import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokio_marine/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:tokio_marine/features/auth/presentation/pages/login_page.dart';
import 'package:tokio_marine/features/home/presentation/pages/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoginSuccessState) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
