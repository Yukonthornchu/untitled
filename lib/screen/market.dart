import 'package:flutter/material.dart';

class market extends StatefulWidget {
  const market({Key? key}) : super(key: key);

  @override
  _marketState createState() => _marketState();
}

class _marketState extends State<market> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Market'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Text(
            'chat',
            style: TextStyle(fontSize: 60),
          ),
        ),
      );
}
