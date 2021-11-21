import 'package:HMSFlutter/core/models/Interest.dart';
import 'package:HMSFlutter/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, mainViewModel, child) {
        List<Interest> interests = mainViewModel.getInterests(excludeAll: true);
        return Container(
          child: ListView.builder(
            itemCount: interests.length,
            itemBuilder: (context, index) {
              Interest interest = interests[index];
              return CheckboxListTile(
                value: interest.isChecked,
                title: Text("${interest.title}"),
                onChanged: (value) {
                  mainViewModel.toggleInterestLike(interest);
                },
              );
            },
          ),
        );
      },
    );
  }
}
