import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:blc_tut/logic/cubit/counter_cubit.dart";

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.title, required this.color});

  final String title;
  final MaterialColor color;

  @override
  State<SecondScreen> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<SecondScreen> {
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = ThemeData(primarySwatch: widget.color);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "You have pushed the button this many times",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Increased!"),
                      duration: Duration(milliseconds: 450),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Decreased!"),
                      duration: Duration(milliseconds: 450),
                    ));
                  }
                },
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      context.read<CounterCubit>().decrement();
                    },
                    tooltip: "Decrement",
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: "Increment",
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
