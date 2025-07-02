import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokio_marine/core/widgets/auth_gate.dart';
import 'package:tokio_marine/depency_injection.dart';
import 'package:tokio_marine/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:tokio_marine/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencyInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(AuthGetCurrentUserEvent())),
      ],
      child: const MaterialApp(
        title: 'Tokio Marine SUPER APP',
          debugShowCheckedModeBanner: false, home: AuthGate()),
    );
  }
}
