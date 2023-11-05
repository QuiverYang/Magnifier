import 'package:flutter/material.dart';
import 'package:magnifier/presentation/bloc/magnifier_bloc.dart';
import 'package:magnifier/presentation/views/magnifier_example.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => MagnifierBloc(),
          child: const MagnifierExample(),
        ),
      ),
    );
  }
}
