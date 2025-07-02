import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokio_marine/core/theme/theme.dart';
import 'package:tokio_marine/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:tokio_marine/features/auth/presentation/pages/login_page.dart';
import 'package:tokio_marine/features/home/presentation/widgets/contracts_section.dart';
import 'package:tokio_marine/features/home/presentation/widgets/home_app_bar.dart';
import 'package:tokio_marine/features/home/presentation/widgets/home_drawer.dart';
import 'package:tokio_marine/features/home/presentation/widgets/my_family_section.dart';
import 'package:tokio_marine/features/home/presentation/widgets/quote_and_buy_section.dart';
import 'package:tokio_marine/features/home/presentation/widgets/user_greeting_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoginSuccessState) {
          return Scaffold(
            appBar: const HomeAppBar(),
            drawer: HomeDrawer(userName: state.user.name),
            backgroundColor: kGreyColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserGreetingCard(userName: state.user.name),
                  const SizedBox(height: 24),
                  const QuoteAndBuySection(),
                  const SizedBox(height: 24),
                  const MyFamilySection(),
                  const SizedBox(height: 24),
                  const ContractsSection(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        }

        return const LoginPage();
      },
    );
  }
}
