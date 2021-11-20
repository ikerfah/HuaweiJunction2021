import 'package:HMSFlutter/core/repository/RemoteRepository.dart';
import 'package:HMSFlutter/ui/details/DealDetails.dart';
import 'package:HMSFlutter/ui/home/HomeScreen.dart';
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
            ProfileScreen(),
          ]),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            // showUnselectedLabels: false,
            unselectedFontSize: 0.0,
            backgroundColor: Colors.white,
            currentIndex: _pageIndex,
            onTap: onTabTapped,
            items: [
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

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**/
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<void>(
          future: _checkHMS(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            final String message = _getMessageFromSnapshot(snapshot);
            return Text(message);
          }),
    );
  }

  Future<void> _checkHMS() async {
    await _testHmsCorePresence();
    await _testAccountByRequestingPushNotificationsToken();
  }

  Future<void> _testHmsCorePresence() async {
    final HmsApiAvailability hmsApiAvailability = new HmsApiAvailability();
    final hmsCoreStatus = await hmsApiAvailability.isHMSAvailable();
    if (hmsCoreStatus != 0) {
      final hmsCoreNotAvailableExplanation =
          await hmsApiAvailability.getErrorString(hmsCoreStatus);
      throw new Exception(hmsCoreNotAvailableExplanation);
    }
  }

  Future<void> _testAccountByRequestingPushNotificationsToken() async {
    await Push.getToken("HCM");
    final pushToken = await Push.getTokenStream.first;
    if (pushToken.isEmpty) {
      throw new Exception(
          'Push notifications token retrieved, but empty. Clear app data and try again.');
    }
  }

  String _getMessageFromSnapshot(AsyncSnapshot<void> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
      case ConnectionState.waiting:
        return 'Checking HMS status ...';
      case ConnectionState.done:
        if (snapshot.hasError) {
          return 'Check HMS failed with ${snapshot.error.toString()}';
        } else {
          return 'All good. Start hacking!';
        }
      case ConnectionState.none:
        return 'Checking HMS disabled.';
    }
  }
}
