import 'package:HMSFlutter/ui/home/ItemExclusiveDeal.dart';
import 'package:HMSFlutter/viewmodels/MainViewModel.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealsListing extends StatefulWidget {
  const DealsListing({Key? key}) : super(key: key);

  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<DealsListing> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (BuildContext context,MainViewModel mainViewModel, Widget? child) { 
        return Container(
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ItemExclusiveDeal(
              deal: mainViewModel.getExclusiveDeals()[index],
            );
          },
          itemCount: mainViewModel.getExclusiveDeals().length,
          pagination: SwiperPagination(
          ),
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      );
      }
    );
  }
}
