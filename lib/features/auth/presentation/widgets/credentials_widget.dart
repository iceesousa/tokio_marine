import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokio_marine/core/theme/theme.dart';
import 'package:tokio_marine/core/utils/validators.dart';
import 'package:tokio_marine/core/widgets/custom_textfield_.dart';
import 'package:tokio_marine/features/auth/presentation/bloc/bloc/auth_bloc.dart';

class CredentialsWidget extends StatelessWidget {
  final bool isLoginSelected;
  final ValueChanged<bool> onTabSelected;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController cpfController;
  final TextEditingController nameController;
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;

  const CredentialsWidget({
    super.key,
    required this.isLoginSelected,
    required this.onTabSelected,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.cpfController,
    required this.nameController,
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 750, maxWidth: 400),
        child: Container(
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: kGreyColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                key: ValueKey(isLoginSelected ? 'login' : 'signup'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTabSelector(),
                  const SizedBox(height: 24),
                  if (!isLoginSelected) ...[
                    CustomTextField(
                        validator: (value) => Validators.name(value),
                        label: 'Nome',
                        icon: Icons.person_outline,
                        controller: nameController),
                    const SizedBox(height: 16),
                    CustomTextField(
                        validator: (value) => Validators.email(value),
                        label: 'E-mail',
                        icon: Icons.email_outlined,
                        controller: emailController),
                    const SizedBox(height: 16),
                  ],
                  CustomTextField(
                      validator: (value) => Validators.cpf(value),
                      label: 'CPF',
                      icon: Icons.person_outline,
                      controller: cpfController),
                  const SizedBox(height: 16),
                  CustomTextField(
                      validator: (value) => Validators.password(value),
                      label: 'Senha',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: passwordController),
                  const SizedBox(height: 20),
                  if (isLoginSelected) _buildOptions(rememberMe),
                  const SizedBox(height: 6),
                  _buildActionButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTabButton('Entrar', true),
        const SizedBox(width: 20),
        _buildTabButton('Cadastrar', false),
      ],
    );
  }

  Widget _buildTabButton(String title, bool isLogin) {
    final bool isSelected = isLoginSelected == isLogin;

    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        onTabSelected(isLogin);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? kBlueColor : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          if (isSelected)
            Container(
              height: 3,
              width: 30,
              decoration: BoxDecoration(
                color: kBlueColor,
                borderRadius: BorderRadius.circular(2),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildOptions(bool rememberMe) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: rememberMe,
                onChanged: onRememberMeChanged,
                activeColor: kBlueColor,
                checkColor: Colors.white,
                side: const BorderSide(color: kBlueColor, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('Lembrar Sempre',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Esqueceu a senha?',
                style: TextStyle(
                    color: kBlueColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [kBlueColor, kBlueColor.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: kBlueColor.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            if (!formKey.currentState!.validate()) {
              return;
            }

            context.read<AuthBloc>().add(isLoginSelected
                ? AuthSignInEvent(
                    password: passwordController.text,
                    cpf: cpfController.text,
                  )
                : AuthSignUpEvent(
                    email: emailController.text,
                    password: passwordController.text,
                    cpf: cpfController.text,
                    name: nameController.text));
          },
          child: BlocSelector<AuthBloc, AuthState, bool>(
            selector: (state) => state is AuthLoadingState,
            builder: (context, isLoading) {
              if (isLoading) {
                return const AbsorbPointer(
                  child: Center(
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                );
              }
              return const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 28,
              );
            },
          ),
        ),
      ),
    );
  }
}
