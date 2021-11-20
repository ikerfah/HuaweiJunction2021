import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:HMSFlutter/core/models/Interest.dart';
import 'package:HMSFlutter/core/repository/RemoteRepository.dart';
import 'package:HMSFlutter/ui/home/DealsListing.dart';
import 'package:HMSFlutter/ui/home/ItemInterest.dart';
import 'package:flutter/material.dart';

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
    selectedInterest = RemoteRepository.getInterests()[0];
  }

  void onDealClicked(Deal deal){
    print("clicked!");
    Navigator.pushNamed(context, 'dealDetails',arguments: deal);
  }
  @override
  Widget build(BuildContext context) {
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
                      interest: RemoteRepository.getInterests()[index],
                      selectedInterest: selectedInterest,
                      onTap: (selectedInterest) {
                        setState(() {
                          this.selectedInterest = selectedInterest;
                        });
                      },
                    );
                  },
                  itemCount: RemoteRepository.getInterests().length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Hero(
                        tag: RemoteRepository.getDeals()[index].heroTag(),
                        child: ItemDeal(
                          deal: RemoteRepository.getDeals()[index],
                          borderColor: Color(0xFFE7ECEE),
                          onTap: (deal) => onDealClicked(deal),
                        ),
                      );
                    },
                    itemCount: RemoteRepository.getDeals().length,
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
  }
}
