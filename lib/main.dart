import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_technologies_task/bloc/registration/registration_bloc.dart';
import 'package:mobile_technologies_task/bloc/registration/registration_event.dart';
import 'package:mobile_technologies_task/routes.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<RegistrationBloc>(
      create: (_) => RegistrationBloc(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
    );
  }
}
