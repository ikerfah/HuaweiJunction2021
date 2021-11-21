import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:HMSFlutter/core/models/Interest.dart';
import 'package:HMSFlutter/ui/details/DealDetails.dart';
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
  @override
  void initState() {
    super.initState();
  }

  void onDealClicked(Deal deal) {
    Navigator.pushNamed(context, 'dealDetails', arguments: deal);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(builder:
        (BuildContext context, MainViewModel mainViewModel, Widget? child) {
      List<Deal> deals = mainViewModel.getDeals();
      List<Interest> checkedInterests = mainViewModel.getCheckedInterests();

      return Column(
        children: [
          Expanded(
            child: DealsListing(),
          ),
          Expanded(
            flex: 3,
            child: checkedInterests.length < 2
                ? //only All in the interests list, hide all the deals
                Center(
                    child: Text("You have no interests preferences"),
                  )
                : Column(
                    children: [
                      Container(
                        height: 50,
                        color: Colors.white,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ItemInterest(
                              interest: checkedInterests[index],
                              selectedInterest: mainViewModel.selectedInterest,
                              onTap: (selectedInterest) {
                                mainViewModel
                                    .setSelectedInterest(selectedInterest);
                              },
                            );
                          },
                          itemCount: checkedInterests.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: deals.isEmpty
                              ? Center(
                                  child: Text("No deals"),
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Hero(
                                      tag: deals[index].heroTag(),
                                      child: ItemDeal(
                                        deal: deals[index],
                                        borderColor: Color(0xFFE7ECEE),
                                        onTap: (deal) => onDealClicked(deal),
                                      ),
                                    );
                                  },
                                  itemCount: deals.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
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
