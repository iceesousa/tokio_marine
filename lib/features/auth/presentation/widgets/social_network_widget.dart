import 'package:flutter/material.dart';

class SocialNetworkWidget extends StatelessWidget {
  const SocialNetworkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Acesse através das redes sociais',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                )),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/icons/facebook.png',
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                // Adicione a lógica de login com o Google aqui
              },
              child: Image.asset(
                'assets/icons/google.png',
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                // Adicione a lógica de login com o Twitter aqui
              },
              child: Image.asset(
                'assets/icons/twitter.png',
                width: 32,
                height: 32,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
