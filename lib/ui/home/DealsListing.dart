import 'package:HMSFlutter/core/repository/RemoteRepository.dart';
import 'package:HMSFlutter/ui/home/ItemExclusiveDeal.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class DealsListing extends StatefulWidget {
  const DealsListing({Key? key}) : super(key: key);

  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<DealsListing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ItemExclusiveDeal(
            deal: RemoteRepository.getExclusiveDeals()[index],
          );
        },
        itemCount: RemoteRepository.getDeals().length,
        pagination: SwiperPagination(
        ),
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
