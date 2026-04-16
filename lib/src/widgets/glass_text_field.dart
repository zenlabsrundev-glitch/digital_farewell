import 'package:flutter/material.dart';

import 'glass_container.dart';

class GlassTextField extends StatefulWidget {
  const GlassTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  late final FocusNode _focusNode = FocusNode()..addListener(_onFocusChanged);
  bool _focused = false;

  void _onFocusChanged() => setState(() => _focused = _focusNode.hasFocus);

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          if (_focused)
            BoxShadow(
              color: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withValues(alpha: 0.22),
              blurRadius: 26,
              offset: const Offset(0, 14),
            ),
        ],
      ),
      child: GlassContainer(
        radius: 26,
        opacity: _focused ? 0.22 : 0.16,
        borderOpacity: _focused ? 0.28 : 0.20,
        blurSigma: 18,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: TextField(
          focusNode: _focusNode,
          controller: widget.controller,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            filled: false,
          ),
        ),
      ),
    );
  }
}

