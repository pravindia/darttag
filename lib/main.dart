import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int fibonacci(int n) {
  if (n < 2) {
    return n;
  }
  return fibonacci(n - 2) + fibonacci(n - 1);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  int res = 0;
  bool isLoading = false;
  List? sortedList;
  List<dynamic>? oneDList;

  @override
  void initState() {
    super.initState();
  }

  // Task 2
  List list = [
    "false",
    false,
    10,
    '10',
    "aads",
    12,
    'ads',
    10.1,
    20,
    12.2,
    'orange',
    false,
    12,
    true,
    'apple',
  ];
  sortDoodles(Order order, List<dynamic> list) {
    sortedList = SplayTreeSet.from(list, ((dynamic key1, dynamic key2) {
      return (Order.ASC == order)
          ? compareGreatest(key1, key2)
          : -compareGreatest(key1, key2);
    })).toList();

    return sortedList;
  }

  int compareGreatest(dynamic left, dynamic right) {
    if (left is bool && right is bool) {
      if (left == right) {
        return 1;
      } else {
        return right ? 1 : -1;
      }
    }
    if (left is bool) {
      return -1;
    }
    if (right is bool) {
      return 1;
    }

    if (left is num && right is num) {
      return left.compareTo(right);
    }
    if (left is String && right is String) {
      return left.compareTo(right);
    }
    if (left is String) {
      return 1;
    }
    if (right is String) {
      return -1;
    }
    return 1;
  }

  // Task 3
  List<List<dynamic>> aList = [
    [10, 2, 4, 6, -2],
    [1, -16, "6", -2, -5],
    [0, 3, 10, -5, 1],
    [0, -4, true, "5", 2],
    [3, 1, 2, 2, -14],
  ];
  transformDoodles(List<List<dynamic>> twoDArray) {
    List<dynamic> arr = [];

    for (var element in twoDArray) {
      arr.addAll(element);
    }
    return arr;
  }

  // Task 4

  @override
  void dispose() {
    textController.dispose();
    res = 0;
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: textController,
                onChanged: (value) {},
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onSubmitted: (value) async {
                  if (kDebugMode) {
                    print("Starting");
                  }
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  try {
                    int i = int.parse(value);
                    // Implemented multi-threading
                    int result = await compute(fibonacci, i);
                    if (mounted)
                      // ignore: curly_braces_in_flow_control_structures
                      setState(() {
                        res = result;
                      });
                  } catch (e) {
                    print(e.toString());
                  }
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (kDebugMode) {
                    print("End : $res");
                  }
                },
              ),
              const SizedBox(height: 10),
              if (isLoading)
                const RepaintBoundary(child: CircularProgressIndicator()),
              const SizedBox(height: 10),
              Text(res.toString()),
              Divider(),
              Text(list.toString()),
              ElevatedButton(
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        sortedList = sortDoodles(Order.ASC, list);
                      });
                    }
                  },
                  child: Text("Sort ascending Task 2")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      sortedList = sortDoodles(Order.DESC, list);
                    });
                  },
                  child: const Text("Sort descending Task 2")),
              if (sortedList != null) Text(sortedList.toString()),
              const Divider(),
              Text(aList.toString()),
              ElevatedButton(
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        oneDList = transformDoodles(aList);
                      });
                    }
                  },
                  child: const Text("Run Task 3")),
              if (oneDList != null) Text(oneDList.toString()),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListType {}

// ignore_for_file: constant_identifier_names
enum Order { ASC, DESC }
