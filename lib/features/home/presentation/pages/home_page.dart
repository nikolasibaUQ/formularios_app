import 'package:flutter/material.dart';
import 'package:formularios_app/features/home/presentation/widgets/option_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [OptionContainer()],
        ),
      ),
    );
  }
}
