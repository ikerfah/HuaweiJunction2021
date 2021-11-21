import 'package:HMSFlutter/core/models/Interest.dart';
import 'package:HMSFlutter/utils/Colors.dart';
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
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
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
            Divider(),
            Text(
              "dividends Users Program",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Allow us to use more privacy data anonymously and join our partner program to earn comission monthly",
                style: TextStyle(
                  fontSize: 10.0,
                  color: grayed,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            CheckboxListTile(
              value: mainViewModel.shareYourLocation,
              title: Text("Share my location"),
              onChanged: (value) {
                mainViewModel.toggleShareYourLocation();
              },
            ),
            CheckboxListTile(
              value: mainViewModel.shareYourSearches,
              title: Text("Share my search queries"),
              onChanged: (value) {
                mainViewModel.toggleShareYourSearches();
              },
            )
          ],
        );
      },
    );
  }
}
