import 'package:flutter/material.dart';

class FadingErrorDialog extends StatefulWidget {
  final String message;
  final Duration duration;
  final VoidCallback onDismissed;

  const FadingErrorDialog({
    super.key,
    required this.message,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<FadingErrorDialog> createState() => _FadingErrorDialogState();
}

class _FadingErrorDialogState extends State<FadingErrorDialog>
    with SingleTickerProviderStateMixin {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    // Inicia o fadeout após (duração - tempo da animação)
    Future.delayed(widget.duration - const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _opacity = 0.0;
        });
      }
    });

    // Remove o popup após a duração completa
    Future.delayed(widget.duration, () {
      widget.onDismissed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            widget.message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
