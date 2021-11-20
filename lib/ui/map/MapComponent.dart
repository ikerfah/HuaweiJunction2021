import 'package:HMSFlutter/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:huawei_location/permission/permission_handler.dart';
import 'package:huawei_map/map.dart';
import 'package:provider/provider.dart';

class MapComponent extends StatefulWidget {
  final Set<Marker> markers;
  final LatLng initialCameraTargetPosition;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;
  final bool tiltGesturesEnabled;
  const MapComponent({
    Key? key,
    required this.markers,
    this.initialCameraTargetPosition = const LatLng(60.186343, 24.8175143),
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomControlsEnabled = true,
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
  }) : super(key: key);

  @override
  _MapComponentState createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  PermissionHandler permissionHandler = PermissionHandler();
  bool isLocationPermissionGranted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      try {
        bool status = await permissionHandler.requestLocationPermission();
        setState(() {
          isLocationPermissionGranted = status;
        });
      } catch (e) {
        print(e.toString);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(builder: (context, mainViewModel, child) {
      return HuaweiMap(
        mapToolbarEnabled: false,
        initialCameraPosition: CameraPosition(
          target: widget.initialCameraTargetPosition,
          zoom: 13,
        ),
        myLocationButtonEnabled: isLocationPermissionGranted,
        myLocationEnabled: isLocationPermissionGranted,
        markersClusteringEnabled: true,
        markers: widget.markers,
        rotateGesturesEnabled: widget.rotateGesturesEnabled,
        scrollGesturesEnabled: widget.scrollGesturesEnabled,
        zoomControlsEnabled: widget.zoomControlsEnabled,
        zoomGesturesEnabled: widget.zoomGesturesEnabled,
        tiltGesturesEnabled: widget.tiltGesturesEnabled,
      );
    });
  }
}
