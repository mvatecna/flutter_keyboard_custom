import 'package:flutter/material.dart';

class KeyKeyboard extends StatelessWidget {
  const KeyKeyboard({
    required this.child,
    this.callback,
    super.key,
  });

  final Function()? callback;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: callback,
        child: Center(child: child),
      ),
    );
  }
}
