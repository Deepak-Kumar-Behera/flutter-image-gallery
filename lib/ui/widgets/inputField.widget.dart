import 'package:flutter/material.dart';

import '../../core/extensions/extension.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.textInputAction,
    this.onSubmitted,
  });

  final String? hintText;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onSubmitted?.call('');
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TextField(
      controller: _controller,
      style: context.textStyles.bodyMedium,
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: context.textStyles.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
        prefixIcon: widget.prefixIcon == null
            ? null
            : IconTheme(data: IconThemeData(color: colors.onSurfaceVariant, size: 20), child: widget.prefixIcon!),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.close, color: colors.onSurfaceVariant, size: 20),
                onPressed: _clear,
              ),
        filled: true,
        fillColor: colors.surfaceContainerHighest,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.primary, width: 1.2),
        ),
      ),
    );
  }
}
