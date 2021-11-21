import 'dart:collection';

import 'package:HMSFlutter/core/models/Company.dart';
import 'package:HMSFlutter/core/models/CustomMarker.dart';
import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:HMSFlutter/ui/home/ItemDeal.dart';
import 'package:HMSFlutter/ui/map/MapComponent.dart';
import 'package:HMSFlutter/utils/Colors.dart';
import 'package:HMSFlutter/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:huawei_scan/HmsScanLibrary.dart';
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
                      showClaimedBanner: false
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
                    height: MediaQuery.of(context).size.width,
                    child: MapComponent(
                      initialCameraTargetPosition: company.latLng,
                      rotateGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      markers: HashSet.from(
                          [CustomMarker.factory(deal, company, null)]),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 15.0),
                    child: TextButton(
                      onPressed: deal.isApplied
                          ? null
                          : () async {
                              bool? hasPermission = await HmsScanPermissions
                                  .requestCameraAndStoragePermissions();
                              if (hasPermission != null && hasPermission) {
                                DefaultViewRequest request =
                                    new DefaultViewRequest(
                                        scanType: HmsScanTypes.QRCode);

                                ScanResponse response =
                                    await HmsScanUtils.startDefaultView(
                                        request);
                                String? result = response.showResult;
                                if (result != null) {
                                  mainViewModel.claimOffer(deal);
                                  showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Claimed!'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                                "You have gained ${deal.claimAmount} €"),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                }
                              } else {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Permission required'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text(
                                                'Camera and storage permission is required to scan'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            deal.isApplied ? grayed : Color(0xFF0074E4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          deal.isApplied ? "Claimed!" : "Claim this offer for ${deal.claimAmount} €",
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
