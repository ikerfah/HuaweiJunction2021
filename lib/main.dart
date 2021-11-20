import 'package:HMSFlutter/core/repository/RemoteRepository.dart';
import 'package:HMSFlutter/ui/details/DealDetails.dart';
import 'package:HMSFlutter/ui/home/HomeScreen.dart';
import 'package:HMSFlutter/ui/map/MapScreen.dart';
import 'package:HMSFlutter/ui/profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:huawei_push/huawei_push_library.dart';

import 'core/models/Deal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _pageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      this._pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HMS Flutter starter app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'dealDetails':
            {
              final deal = settings.arguments as Deal;
              return MaterialPageRoute(builder: (context) {
                return SafeArea(
                    child: Material(child: DealDetails(deal: deal)));
              });
            }
          default:
            {
              assert(false, 'Need to implement ${settings.name}');
            }
        }
      },
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(index: _pageIndex, children: <Widget>[
            HomeScreen(),
            MapScreen(),
            ProfileScreen(),
          ]),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            unselectedFontSize: 0.0,
            backgroundColor: Colors.white,
            currentIndex: _pageIndex,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                label: "Map",
                icon: Icon(Icons.map),
              ),
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.account_circle_rounded),
              )
            ],
          ),
          floatingActionButton: null,
        ),
      ),
    );
  }
}
