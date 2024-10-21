import 'package:flutter/material.dart';

class AppCircleIndicator extends StatelessWidget {
  const AppCircleIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        key: const ValueKey('AppCircleIndicator'),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
