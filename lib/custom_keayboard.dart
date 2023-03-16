import 'package:flutter/material.dart';
import 'package:flutter_keyboard_custom/textkey.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
    this.onTextInput,
    this.onBackspace,
    super.key,
  });

  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;

  void _textInputHandler(String text) => onTextInput?.call(text);

  void _backspaceHandler() => onBackspace?.call();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        height: 160,
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            buildRowOne(),
            buildRowTwo(),
            buildRowThree(),
          ],
        ),
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '1',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '2',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '3',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '4',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '5',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowTwo() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: 'a',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'b',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'c',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'd',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'e',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowThree() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: ' ',
            flex: 4,
            onTextInput: _textInputHandler,
          ),
          TextKey(
            isBackSpace: true,
            onBackspace: _backspaceHandler,
          ),
        ],
      ),
    );
  }
}
