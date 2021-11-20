import 'package:HMSFlutter/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:huawei_map/map.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
          future: _checkHMS(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Text("Checking HMS status ...");
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                      'Check HMS failed with ${snapshot.error.toString()}');
                } else {
                  return Consumer<MainViewModel>(builder: (BuildContext context,
                      MainViewModel mainViewModel, Widget? child) {
                    return HuaweiMap(
                      mapToolbarEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: const LatLng(60.186343, 24.8175143),
                        zoom: 13,
                      ),
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      markersClusteringEnabled: true,
                      markers: Set<Marker>.from(mainViewModel
                              .getDeals()
                              .map((deal) => Marker(
                                    markerId: MarkerId('marker_id_${deal.id}'),
                                    position: mainViewModel
                                        .getCompanyById(deal.companyId)
                                        .latLng,
                                    clusterable: true,
                                    infoWindow: InfoWindow(
                                        title: '${deal.title}',
                                        snippet: '${deal.description}',
                                        onClick: () => {
                                              Navigator.pushNamed(
                                                  context, 'dealDetails',
                                                  arguments: deal)
                                            }),
                                  ))
                              .toList())
                          .toSet(),
                    );
                  });
                }
              case ConnectionState.none:
                return Text('Checking HMS disabled.');
            }
          }),
    );
  }

  Future<void> _checkHMS() async {
    await _testHmsCorePresence();
    // await _testAccountByRequestingPushNotificationsToken();
  }

  Future<void> _testHmsCorePresence() async {
    final HmsApiAvailability hmsApiAvailability = new HmsApiAvailability();
    final hmsCoreStatus = await hmsApiAvailability.isHMSAvailable();
    if (hmsCoreStatus != 0) {
      final hmsCoreNotAvailableExplanation =
          await hmsApiAvailability.getErrorString(hmsCoreStatus);
      throw new Exception(hmsCoreNotAvailableExplanation);
    }
  }

  // Future<void> _testAccountByRequestingPushNotificationsToken() async {
  //   await Push.getToken("HCM");
  //   final pushToken = await Push.getTokenStream.first;
  //   if (pushToken.isEmpty) {
  //     throw new Exception(
  //         'Push notifications token retrieved, but empty. Clear app data and try again.');
  //   }
  // }

  String _getMessageFromSnapshot(AsyncSnapshot<void> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
      case ConnectionState.waiting:
        return 'Checking HMS status ...';
      case ConnectionState.done:
        if (snapshot.hasError) {
          return 'Check HMS failed with ${snapshot.error.toString()}';
        } else {
          return 'All good. Start hacking!';
        }
      case ConnectionState.none:
        return 'Checking HMS disabled.';
    }
  }
}
