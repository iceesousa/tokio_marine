import 'package:flutter/material.dart';
import 'package:tokio_marine/core/theme/theme.dart';

class MyFamilySection extends StatelessWidget {
  const MyFamilySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Minha Família',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kBlueColor, width: 2),
                    ),
                    child: const Icon(Icons.add, color: kBlueColor, size: 30),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Adicione aqui membros da sua família e compartilhe os seguros com eles.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}