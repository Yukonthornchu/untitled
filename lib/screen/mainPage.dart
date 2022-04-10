import 'package:flutter/material.dart';
import 'package:untitled/screen/favorite.dart';
import 'package:untitled/screen/history.dart';
import 'package:untitled/screen/market.dart';
import 'package:untitled/screen/notification.dart';
import 'package:untitled/screen/profile.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int currentIndex = 2;
  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final screens = [
    notification(),
    favorite(),
    market(),
    history(),
    profile(),
  ];
  // final List<Widget> _pageWidget= <Widget>[
  //   const notification(),
  //   const favorite(),
  //   const market(),
  //   const history(),
  //   const profile(),

  // ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('BitFriend'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.star),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const favorite()),
                  );
                }),
          ],
          backgroundColor: Color(0xff02051A),

          // centerTitle: true,
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
// type: BottomNavigationBarType.fixed,
// backgroundColor: Colors.yellowAccent,
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.black,
          iconSize: 30,
          selectedFontSize: 15,
// unselectedFontSize: 12,
// showSelectedLabels: true,
// showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: onTapped,
          //     (index) => setState(
          //   () => currentIndex = index,
          // ),

          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.yellowAccent,
                icon: Icon(Icons.notifications_on_outlined),
                label: 'Notification'),
            BottomNavigationBarItem(
                backgroundColor: Colors.yellowAccent,
                icon: Icon(Icons.star),
                label: 'Favorite'),
            BottomNavigationBarItem(
                backgroundColor: Colors.yellowAccent,
                icon: Icon(Icons.leaderboard_rounded),
                label: 'Market'),
            BottomNavigationBarItem(
                backgroundColor: Colors.yellowAccent,
                icon: Icon(Icons.history),
                label: 'History'),
            BottomNavigationBarItem(
                backgroundColor: Colors.yellowAccent,
                icon: Icon(Icons.person),
                label: 'Profile'),
          ],
        ),
      );
}
