import 'package:HMSFlutter/core/models/Company.dart';
import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:HMSFlutter/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDeal extends StatelessWidget {
  const ItemDeal({
    Key? key,
    required this.deal,
    this.borderColor = Colors.transparent,
    this.onTap,
  }) : super(key: key);

  final Deal deal;
  final double kSpaceBetweenTitles = 10.0;
  final borderColor;
  final Function(Deal)? onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(builder: (context, mainViewModel, child) {
      Company company = mainViewModel.getCompanyById(deal.companyId);
      return Material(
        child: InkWell(
          onTap: () => {onTap?.call(deal)},
          child: Container(
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
                        Text(
                          "${deal.description}",
                          style: TextStyle(
                            color: Color(0xFF71828A),
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
                                "3 Km",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color(0xFF0074E4),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }
}
