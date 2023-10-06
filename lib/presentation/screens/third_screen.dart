import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:blc_tut/logic/cubit/counter_cubit.dart";

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key, required this.title, required this.color});

  final String title;
  final MaterialColor color;

  @override
  State<ThirdScreen> createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<ThirdScreen> {
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
                      duration: Duration(milliseconds: 80),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Decreased!"),
                      duration: Duration(milliseconds: 80),
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
                    backgroundColor: widget.color,
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: "Increment",
                    backgroundColor: widget.color,
                    child: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
