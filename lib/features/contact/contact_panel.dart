import 'package:flutter/material.dart';

class ContactPanel extends StatelessWidget {
  const ContactPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(20, (index) => const Text('ContactPanel')),
    );
  }
}
