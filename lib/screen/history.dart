
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  _historyState createState() => _historyState();

}

class _historyState extends State<history> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('History'),
      //   backgroundColor: Colors.black,
      // ),

      body: Row(
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  'History',
                  style: TextStyle(fontSize: 60),

                ),

              ),

              // IconButton(
              //   icon: Icon(Icons.bluetooth),
              //   iconSize: 48,
              //   tooltip: 'Toggle Bluetooth',
              //   onPressed: () {
              //     setState(() {
              //       _isBluetoothOn = !_isBluetoothOn;
              //     });
              //   },
              // ),
              FavoriteButton(

                isFavorite: false,
                valueChanged: (_isFavorite) {
                  print('Is Favorite : $_isFavorite');
                },
              ),




            ],
          ),
        ],
      ),
    );
  }
}

// เก็บไว้เผื่อใช้
// TextButton.icon(
// onPressed: () {print("kong");},
// icon: Icon(Icons.email),
// label: Text("Contact me"),
// style: ElevatedButton.styleFrom(
// textStyle: TextStyle(fontSize: 15),
// ),
// ),
