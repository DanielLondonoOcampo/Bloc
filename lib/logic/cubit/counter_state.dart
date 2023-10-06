part of 'counter_cubit.dart';

final class CounterState extends Equatable {
  final int counterValue;
  final bool wasIncremented;

  const CounterState({
    // App must have valid counter at all times, hence its required
    required this.counterValue,
    required this.wasIncremented,
  });
  CounterState copyWith({int? counterValue, bool? wasIncremented}) {
    return CounterState(
        counterValue: counterValue ?? this.counterValue,
        wasIncremented: wasIncremented ?? this.wasIncremented);
  }

  @override
  List<Object> get props => [counterValue, wasIncremented];
}
