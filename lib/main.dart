import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';

import '/services/amqp/amqp_request.dart';
import 'services/amqp/amqp_client_manager.dart';
import 'services/amqp/amqp_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rabbit Sender',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
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
                            content: Column(children: [
                              Row(
                                children: const [
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                ],
                              ),                              
                              Row(
                                children: const [
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                ],
                              ),                              
                              Row(
                                children: const [
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                ],
                              ),                              
                              Row(
                                children: const [
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                  Text('asdasd'),
                                ],
                              ),
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
              itemCount: 30,
            ),
          )
        ],
      ),
    );
  }
}
