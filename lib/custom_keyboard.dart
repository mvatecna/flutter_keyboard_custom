import 'package:flutter/material.dart';
import 'package:flutter_keyboard_custom/textkey.dart';

class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard({
    this.onTextInput,
    this.onBackspace,
    super.key,
  });

  final Function(String s)? onTextInput;
  final VoidCallback? onBackspace;

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  bool isLetter = true;

  final list = ["7 / A", "8 / D", "9 / F", "4 / M", "5 / N", "6 / P", "1 / R", "2", "3"];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * .45,
        color: Theme.of(context).cardColor,
        child: GridView.count(
          padding: const EdgeInsets.all(8),
          crossAxisCount: 3,
          children: [
            ...list
                .map(
                  (e) => TextKey(
                    callback: () => _textInputHandler(e),
                    child: textKey(e),
                  ),
                )
                .toList(),
            TextKey(
              callback: _toggleIsABCTap,
              child: Text(
                "ABC",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: isLetter ? Colors.green : Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
            ),
            TextKey(
              callback: () => _textInputHandler("0"),
              child: textKey("0"),
            ),
            TextKey(
              callback: _backspaceHandler,
              child: Icon(
                Icons.backspace,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _textInputHandler(String text) => widget.onTextInput?.call(_splitValueKeyboard(text) ?? "");
  void _backspaceHandler() => widget.onBackspace?.call();

  Widget textKey(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
    );
  }

  String? _splitValueKeyboard(String? s) {
    final list = s?.split("/");
    if (isLetter) {
      isLetter = !isLetter;
      setState(() {});
      return list?.last.trim();
    }
    return list?.first.trim();
  }

  void _toggleIsABCTap() {
    isLetter = !isLetter;
    setState(() {});
  }
}
