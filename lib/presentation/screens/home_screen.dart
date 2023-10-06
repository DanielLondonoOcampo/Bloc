import "package:blc_tut/constants/enums.dart";
import "package:blc_tut/logic/cubit/internet_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:blc_tut/logic/cubit/counter_cubit.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final MaterialColor color;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = ThemeData(primarySwatch: widget.color);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.WiFi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Theme(
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "You have pushed the button this many times",
                    style: TextStyle(
                        color: Color.fromARGB(255, 97, 97, 97), fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
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
                const SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/second");
                  },
                  color: Colors.redAccent,
                  child: const Text(
                    "Go to second screen",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/third");
                  },
                  color: Colors.greenAccent,
                  child: const Text("Go to third screen",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
