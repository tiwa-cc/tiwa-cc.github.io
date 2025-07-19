import 'package:flutter/material.dart';

final class ContactViewButton extends StatelessWidget {
  const ContactViewButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text('CONTACT'));
  }
}
