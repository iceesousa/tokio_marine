import 'package:flutter/material.dart';
import 'package:tokio_marine/core/theme/theme.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;
  final ShapeBorder? shape;
  final Color? backgroundColor;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions = const [],
    this.shape,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isWide = mediaQuery.size.width > 600;

    return Dialog(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
      backgroundColor: backgroundColor ?? Colors.black,
      elevation: 12,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isWide ? 500 : double.infinity,
          maxHeight: mediaQuery.size.height * 0.9,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: kTitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: content,
                ),
              ),
              if (actions.isNotEmpty) ...[
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: actions,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
