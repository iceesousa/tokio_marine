import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokio_marine/core/theme/theme.dart';
import 'package:tokio_marine/core/widgets/alert_dialog.dart';
import 'package:tokio_marine/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:tokio_marine/features/auth/presentation/widgets/credentials_widget.dart';
import 'package:tokio_marine/features/auth/presentation/widgets/social_network_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoginSelected = true;
  bool _rememberMe = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpfController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserCredentials();
  }

  void _loadUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('rememberMe') ?? false;

    if (rememberMe) {
      final cpf = prefs.getString('cpf') ?? '';
      final password = prefs.getString('password') ?? '';
      setState(() {
        _cpfController.text = cpf;
        _passwordController.text = password;
        _rememberMe = rememberMe;
      });
    }
  }

  void _saveUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setBool('rememberMe', true);
      await prefs.setString('cpf', _cpfController.text);
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.clear();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _cpfController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ismobile = MediaQuery.of(context).size.width < 600;

    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthLoginSuccessState) {
        _saveUserCredentials();
      } else if (state is AuthRegisterSuccessState) {
        showDialog(
            context: context,
            builder: (context) {
              return const CustomAlertDialog(
                  title: 'Cadastro realizado com sucesso!',
                  content: Text(
                    'Agora você pode fazer login.',
                    style: TextStyle(
                        color: Colors.white, fontSize: kDefaultFontSize),
                  ));
            });
      } else if (state is AuthErrorState) {
        showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                backgroundColor: kGreyColor,
                title: 'Erro de autenticação',
                content: Text(state.message,
                    style: const TextStyle(
                        color: Colors.white, fontSize: kDefaultFontSize)),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: kBlueColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      }
    }, builder: (context, state) {
      return LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF3AAFA9), Color(0xFFD4DD4F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: kGreyColor,
                    ),
                  )
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(kPrimaryPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 450,
                        child: Column(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    child: Image.asset(
                                        'assets/images/logo-tokio-dark.png',
                                        color: Colors.white,
                                        height: 100,
                                        width: 150),
                                  ),
                                ),
                              ],
                            ),
                            const Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                      text: 'Bem vindo!\n',
                                      style: TextStyle(
                                        fontSize: kTitleFontSize,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              'Aqui voce gerencia seus seguros e de seus familiares em poucos cliques!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: kSubtitleFontSize,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: ismobile
                              ? MediaQuery.of(context).size.height * 0.004
                              : MediaQuery.of(context).size.height * 0.01),
                      CredentialsWidget(
                        isLoginSelected: _isLoginSelected,
                        onTabSelected: (isLogin) {
                          setState(() {
                            _isLoginSelected = isLogin;
                            _formKey.currentState?.reset();
                            _emailController.clear();
                            _passwordController.clear();
                            _cpfController.clear();
                            _nameController.clear();
                          });
                        },
                        formKey: _formKey,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        cpfController: _cpfController,
                        nameController: _nameController,
                        rememberMe: _rememberMe,
                        onRememberMeChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const FlutterLogo(
                        size: 30,
                      ),
                      const SizedBox(height: 16),
                      if (_isLoginSelected) ...[const SocialNetworkWidget()],
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
