import 'package:HMSFlutter/core/models/Company.dart';
import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:HMSFlutter/utils/Colors.dart';
import 'package:HMSFlutter/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDeal extends StatelessWidget {
  const ItemDeal({
    Key? key,
    required this.deal,
    this.borderColor = Colors.transparent,
    this.onTap,
    this.showClaimedBanner = true,
  }) : super(key: key);

  final Deal deal;
  final double kSpaceBetweenTitles = 10.0;
  final borderColor;
  final Function(Deal)? onTap;
  final bool showClaimedBanner;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(builder: (context, mainViewModel, child) {
      Company company = mainViewModel.getCompanyById(deal.companyId);
      Widget child = Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      "${company.logoPath}",
                      color: Colors.black,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${deal.title}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            "${company.rating}",
                          ),
                          backgroundColor: Color(0xFFFFF9E5),
                          avatar: Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Chip(
                          label: Text(
                            "${company.distance} Km",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Color(0xFF0074E4),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Chip(
                          label: Text(
                            "${deal.claimAmount} €",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Color(0xFFCF1E43),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ));

      if (showClaimedBanner && deal.isApplied) {
        child = Banner(
          textDirection: TextDirection.ltr,
          location: BannerLocation.topEnd,
          message: 'Claimed',
          color: borderColor,
          textStyle:
              TextStyle(color: Colors.black.withOpacity(0.2), fontSize: 10.0),
          child: child,
        );
      }
      return Material(
        child: InkWell(
          onTap: () => {onTap?.call(deal)},
          child: ClipRect(
            child: child,
          ),
        ),
      );
    });
  }
}
