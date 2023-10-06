import 'dart:async';
import 'package:blc_tut/constants/enums.dart';
import 'package:blc_tut/logic/cubit/internet_cubit.dart';
import 'package:bloc/bloc.dart';
import "package:equatable/equatable.dart";

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(counterValue: 0, wasIncremented: false));

  void increment() => emit(state.copyWith(
      counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(state.copyWith(
      counterValue: state.counterValue - 1, wasIncremented: false));
}
