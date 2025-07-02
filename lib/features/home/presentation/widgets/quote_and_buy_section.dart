import 'package:flutter/material.dart';
import 'package:tokio_marine/features/home/presentation/widgets/web_view.dart';

class QuoteAndBuySection extends StatelessWidget {
  const QuoteAndBuySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cotar e Contratar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: _QuoteIcon(
                    imageUrl: 'assets/icons/policy-icon-car.png',
                    label: 'Automóvel',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WebViewPage(
                          url: 'https://jsonplaceholder.typicode.com/',
                        ),
                      ),
                    ),
                  ),
                ),
                const _QuoteIcon(
                    imageUrl: 'assets/icons/policy-icon-residential.png',
                    label: 'Residência'),
                const _QuoteIcon(
                    imageUrl: 'assets/icons/policy-icon-life.png',
                    label: 'Vida'),
                const _QuoteIcon(
                    imageUrl: 'assets/icons/policy-icon-personal-accident.png',
                    label: 'Acidentes Pessoais'),
                const _QuoteIcon(
                    imageUrl: 'assets/icons/policy-icon-moto.png',
                    label: 'Moto'),
                const _QuoteIcon(
                    imageUrl: 'assets/icons/policy-icon-enterprise.png',
                    label: 'Empresa'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuoteIcon extends StatelessWidget {
  final Function()? onTap;
  final String imageUrl;
  final String label;

  const _QuoteIcon({required this.imageUrl, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFF2C3E50),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    imageUrl,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
