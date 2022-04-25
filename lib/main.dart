import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_requester/providers/connections_provider.dart';

import 'widgets/connections_selector/connections_selector_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConnectionsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Rabbit Sender',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rabbit Sender'),
        actions: const [
          ConnectionsSelector()
        ]
      ),
      body: Row(
        children: [
          Drawer(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                  // color: Colors.black,
                  ),
              itemBuilder: (context, index) => TextButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text("My Title $index"),
                            content: Column(children: const [
                              Text('Placeholder')
                            ]),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          )),
                  child: Text('$index')),
              itemCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
