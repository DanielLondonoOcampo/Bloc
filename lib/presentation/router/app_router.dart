import 'package:blc_tut/logic/cubit/counter_cubit.dart';
import 'package:blc_tut/presentation/screens/home_screen.dart';
import 'package:blc_tut/presentation/screens/second_screen.dart';
import 'package:blc_tut/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _counterCubit,
                child: const HomeScreen(title: "Home", color: Colors.blue)));
      case "/second":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _counterCubit,
                child: const SecondScreen(title: "Second", color: Colors.red)));
      case "/third":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _counterCubit,
                child: const ThirdScreen(title: "Third", color: Colors.green)));
      default:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _counterCubit,
                child: const HomeScreen(title: "Home", color: Colors.blue)));
    }
  }
}
