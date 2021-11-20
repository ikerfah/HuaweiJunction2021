import 'package:HMSFlutter/core/models/Company.dart';
import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:HMSFlutter/ui/home/ItemDeal.dart';
import 'package:HMSFlutter/utils/Colors.dart';
import 'package:HMSFlutter/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetails extends StatefulWidget {
  final Deal deal;

  const DealDetails({
    Key? key,
    required this.deal,
  }) : super(key: key);

  @override
  _DealDetailsState createState() => _DealDetailsState();
}

class _DealDetailsState extends State<DealDetails> {
  Widget _detailsListTile({String title = "", IconData? icon}) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
          )
        ],
      ),
      title: Text("$title"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(builder: (context, mainViewModel, child) {
      Company company = mainViewModel.getCompanyById(widget.deal.companyId);
      Deal deal = mainViewModel.getDealById(widget.deal.id);
      return Scaffold(
        body: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 40,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        child: Text(
                          "${company.name}",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: IconButton(
                      onPressed: () =>
                          {mainViewModel.toggleCompanyLike(company)},
                      icon: Icon(
                        company.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        size: 40,
                        color: company.isLiked ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Hero(
                    tag: widget.deal.heroTag(),
                    child: ItemDeal(
                      deal: deal,
                    ),
                  ),
                  _detailsListTile(
                      title: company.location, icon: Icons.location_pin),
                  _detailsListTile(
                    title: company.phone,
                    icon: Icons.phone_android,
                  ),
                  _detailsListTile(
                    title: company.website,
                    icon: Icons.link,
                  ),
                  _detailsListTile(
                    title: deal.dealValidity,
                    icon: Icons.av_timer,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 15.0),
                    child: TextButton(
                      onPressed: deal.isApplied
                          ? null
                          : () => {mainViewModel.claimOffer(deal)},
                      style: TextButton.styleFrom(
                        backgroundColor:
                            deal.isApplied ? grayed : Color(0xFF0074E4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          deal.isApplied
                              ? "Claimed!"
                              : "Claim this offer",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: null,
      );
    });
  }
}
