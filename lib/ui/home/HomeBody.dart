import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:HMSFlutter/core/models/Interest.dart';
import 'package:HMSFlutter/ui/home/DealsListing.dart';
import 'package:HMSFlutter/ui/home/ItemInterest.dart';
import 'package:HMSFlutter/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ItemDeal.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Interest? selectedInterest;

  @override
  void initState() {
    super.initState();
  }

  void onDealClicked(Deal deal) {
    print("clicked!");
    Navigator.pushNamed(context, 'dealDetails', arguments: deal);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(builder:
        (BuildContext context, MainViewModel mainViewModel, Widget? child) {
      selectedInterest = selectedInterest ?? mainViewModel.getInterests()[0];
      return Column(
        children: [
          Expanded(
            child: DealsListing(),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.white,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ItemInterest(
                        interest: mainViewModel.getInterests()[index],
                        selectedInterest: selectedInterest,
                        onTap: (selectedInterest) {
                          setState(() {
                            this.selectedInterest = selectedInterest;
                          });
                        },
                      );
                    },
                    itemCount: mainViewModel.getInterests().length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: mainViewModel.getDeals()[index].heroTag(),
                          child: ItemDeal(
                            deal: mainViewModel.getDeals()[index],
                            borderColor: Color(0xFFE7ECEE),
                            onTap: (deal) => onDealClicked(deal),
                          ),
                        );
                      },
                      itemCount: mainViewModel.getDeals().length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10.0,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
