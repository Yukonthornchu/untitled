import 'package:flutter/material.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  _favoriteState createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Favorite',
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
