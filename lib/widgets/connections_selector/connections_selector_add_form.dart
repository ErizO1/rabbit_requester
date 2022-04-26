import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../models/connection_model.dart';

class ConnectionsSelectorAddForm extends StatefulWidget {
  final Completer<ConnectionModel> completerCallback;

  const ConnectionsSelectorAddForm({Key? key, required this.completerCallback})
      : super(key: key);

  @override
  State<ConnectionsSelectorAddForm> createState() =>
      _ConnectionsSelectorAddFormState();
}

class _ConnectionsSelectorAddFormState
    extends State<ConnectionsSelectorAddForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: AlertDialog(
        title: const Text("Create connection"),
        content: Column(children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(
              hintText: 'Connection name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          FormBuilderTextField(
            name: 'host',
            decoration: const InputDecoration(
              hintText: 'Host',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          FormBuilderTextField(
            name: 'port',
            decoration: const InputDecoration(
              hintText: 'Port',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          FormBuilderTextField(
            name: 'username',
            decoration: const InputDecoration(
              hintText: 'Username',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          FormBuilderTextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            name: 'password',
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ]),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _formKey.currentState!.save();
              _formKey.currentState!.validate();
              if (_formKey.currentState!.isValid) {
                final id = const Uuid().v4();
                final values = _formKey.currentState!.value;
                final newConnection = ConnectionModel(
                  id: id,
                  name: values['name'],
                  host: values['host'],
                  username: values['username'],
                  password: values['password'],
                  port: '5672',
                );
                widget.completerCallback.complete(newConnection);
                Navigator.pop(context, 'OK');
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
