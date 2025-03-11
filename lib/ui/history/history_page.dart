import 'package:flutter/material.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.light,
      body: const Center(child: Text('History')),
    );
  }
}
