import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Semantics(header: true, child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
    );
  }
}
