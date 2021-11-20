import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:flutter/material.dart';

class ItemExclusiveDeal extends StatelessWidget {
  const ItemExclusiveDeal({Key? key, required this.deal, this.onTap})
      : super(key: key);

  final Deal deal;
  final double kSpaceBetweenTitles = 10.0;
  final Function(Deal)? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => {onTap?.call(deal)},
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Color(0xFFF2EAEA),
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "${deal.company.logoPath}",
                      color: Colors.white,
                      height: 50,
                      width: 50,
                    ),
                    Container(
                      height: kSpaceBetweenTitles,
                    ),
                    Text(
                      "${deal.title}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: kSpaceBetweenTitles,
                    ),
                    Text(
                      "${deal.description}",
                      style: TextStyle(
                        color: Color(0xFF71828A),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: Image.asset("${deal.imagePath}",fit: BoxFit.fill,)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
