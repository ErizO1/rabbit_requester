import 'package:flutter/material.dart';

class ConnectionsSelectorAdd {
  const ConnectionsSelectorAdd();

  static DropdownMenuItem<String> create({
    Key? key,
  }) => DropdownMenuItem(
      key: key,
      value: '',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: const [
          Text('Create new connection'),
          Icon(
            Icons.add_circle_outline,
            color: Colors.black54,
          )
        ],
      ),
    );
}
