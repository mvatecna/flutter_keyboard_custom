import 'package:flutter/material.dart';
import 'package:flutter_keyboard_custom/custom_keyboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const KeyboardDemo(),
    );
  }
}

class KeyboardDemo extends StatefulWidget {
  const KeyboardDemo({super.key});

  @override
  State<KeyboardDemo> createState() => _KeyboardDemoState();
}

class _KeyboardDemoState extends State<KeyboardDemo> {
  final TextEditingController _controller = TextEditingController();
  bool _readOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              style: const TextStyle(fontSize: 24),
              autofocus: true,
              showCursor: true,
              readOnly: _readOnly,
              onTap: () => _readOnly ? bottomSheet() : null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Keyboard base"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Switch(
                    value: _readOnly,
                    onChanged: (_) {
                      setState(() {
                        _readOnly = !_readOnly;
                      });
                      FocusScope.of(context).requestFocus(FocusNode());
                    }),
              ),
              const Text("Keyboard simplified"),
            ],
          ),
          const Spacer(),
          FilledButton(
            child: const Text("Show keyboard custom"),
            onPressed: () => bottomSheet(),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .7,
        ),
        builder: (_) {
          return CustomKeyboard(
            onTextInput: (text) => _insertText(text),
            onBackspace: () => _backspace(),
          );
        });
  }

  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(newStart, newEnd, '');
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) => value & 0xF800 == 0xD800;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
