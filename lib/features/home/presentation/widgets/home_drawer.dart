import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokio_marine/core/theme/theme.dart';
import 'package:tokio_marine/features/auth/presentation/bloc/bloc/auth_bloc.dart';

class HomeDrawer extends StatelessWidget {
  final String userName;

  const HomeDrawer({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kGreyColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Olá, $userName',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state is AuthLoginSuccessState
                    ? Text(state.user.email)
                    : const Text("cliente@email.com");
              },
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: kBlueColor),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00A79D), Color(0xFF1E4E62)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          _buildListTile(
              icon: Icons.home, title: 'Home / Seguros', onTap: () {}),
          _buildListTile(
              icon: Icons.file_copy,
              title: 'Minhas Contratações',
              onTap: () {}),
          _buildListTile(
              icon: Icons.warning, title: 'Meus Sinistros', onTap: () {}),
          _buildListTile(
              icon: Icons.family_restroom,
              title: 'Minha Família',
              onTap: () {}),
          _buildListTile(
              icon: Icons.business, title: 'Meus Bens', onTap: () {}),
          _buildListTile(
              icon: Icons.payment, title: 'Pagamentos', onTap: () {}),
          _buildListTile(icon: Icons.shield, title: 'Coberturas', onTap: () {}),
          _buildListTile(
              icon: Icons.qr_code_scanner,
              title: 'Validar Boleto',
              onTap: () {}),
          _buildListTile(
              icon: Icons.phone, title: 'Telefones Importantes', onTap: () {}),
          const Divider(),
          _buildListTile(
              icon: Icons.settings, title: 'Configurações', onTap: () {}),
          _buildListTile(
              icon: Icons.logout,
              title: 'Sair',
              onTap: () {
                context.read<AuthBloc>().add(AuthSignOutEvent());
              }),
        ],
      ),
    );
  }

  ListTile _buildListTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: kBlueColor),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
