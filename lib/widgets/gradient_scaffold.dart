import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const GradientScaffold({Key? key, this.appBar, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(child: body),
      ),
    );
  }
}
