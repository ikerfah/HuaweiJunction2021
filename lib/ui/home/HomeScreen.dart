import 'package:HMSFlutter/ui/CustomAppBar.dart';
import 'package:HMSFlutter/ui/home/HomeBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomAppBar(),
          Expanded(child: HomeBody()),
        ],
      ),
    );
  }
}
