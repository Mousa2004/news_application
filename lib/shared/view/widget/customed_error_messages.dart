import 'package:flutter/material.dart';

class CustomedErrorMessages extends StatelessWidget {
  final String message;
  const CustomedErrorMessages({
    super.key,
    this.message = "Something error messaes",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
