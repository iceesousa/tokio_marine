import 'package:flutter/material.dart';

class ContractsSection extends StatelessWidget {
  const ContractsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contratados',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Icon(Icons.sentiment_dissatisfied_outlined,
                    color: Colors.white54, size: 45),
                SizedBox(height: 12),
                Text(
                  'Você ainda não possui seguros contratados.',
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