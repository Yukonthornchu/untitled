import 'package:flutter/cupertino.dart';
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
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.grey,
          //สีขาว Theme.of(context).scaffoldBackgroundColor
            title: Text('Favorite',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold)),
            // pinned: true,

            snap: true,
            centerTitle: true,
            floating: true,
          ),
        ],
        body: Center(
          child: Text(
            'Favorite',
            style: TextStyle(fontSize: 60),
          ),
        ),
      ),
    );
  }
}











