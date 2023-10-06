import 'package:blc_tut/logic/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });
    tearDown(() {
      counterCubit.close();
    });

    test("Initial state should be 0, wasIncremented should be false", () {
      expect(counterCubit.state,
          CounterState(counterValue: 0, wasIncremented: false));
    });

    blocTest<CounterCubit, CounterState>(
        "The cubit should return a state value of 1 and wasIncremented == true with increment()",
        build: () => counterCubit,
        act: (cubit) => cubit.increment(),
        expect: () => [CounterState(counterValue: 1, wasIncremented: true)]);
    blocTest<CounterCubit, CounterState>(
        "The cubit should return a state value of -1 and wasIncremented == false with decrement()",
        build: () => counterCubit,
        act: (cubit) => cubit.decrement(),
        expect: () => [CounterState(counterValue: -1, wasIncremented: false)]);
  });
}
