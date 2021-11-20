import 'package:HMSFlutter/core/models/Company.dart';
import 'package:huawei_map/map.dart';

import 'Deal.dart';

class CustomMarker {
  static Marker factory(Deal deal, Company company, Function(Deal)? onClick) {
    return Marker(
      markerId: MarkerId('marker_id_${deal.id}'),
      position: company.latLng,
      clusterable: true,
      infoWindow: InfoWindow(
          title: '${deal.title}',
          snippet: '${deal.description}',
          onClick: () => {onClick?.call(deal)}),
    );
  }
}
