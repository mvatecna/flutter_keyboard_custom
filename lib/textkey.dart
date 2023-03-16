import 'package:flutter/material.dart';

class TextKey extends StatelessWidget {
  const TextKey({
    this.text,
    this.flex = 1,
    this.isBackSpace = false,
    this.onTextInput,
    this.onBackspace,
    super.key,
  });

  final String? text;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final int flex;
  final bool isBackSpace;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: appTheme.colorScheme.secondary,
          child: InkWell(
            onTap: () => isBackSpace
                ? onBackspace?.call()
                : onTextInput?.call(text ?? ""),
            child: SizedBox(
              child: Center(
                child: isBackSpace
                    ? Icon(
                        Icons.backspace,
                        color: appTheme.colorScheme.onSecondary,
                      )
                    : Text(
                        text ?? "",
                        style: appTheme.textTheme.bodyLarge?.copyWith(
                          color: appTheme.colorScheme.onSecondary,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
