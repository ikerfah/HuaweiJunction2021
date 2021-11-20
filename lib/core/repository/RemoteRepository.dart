import 'package:HMSFlutter/core/models/Company.dart';
import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:HMSFlutter/core/models/Interest.dart';
import 'package:huawei_map/map.dart';

class RemoteRepository {
  static Company nike = Company(
    id: 1,
    name: "Nike",
    logoPath: "assets/nike.png",
    rating: 4.8,
    location: "Rastila 02600, Helsinki",
    phone: "+358 532-512-5125",
    website: "https://www.nike.com",
    latLng: LatLng(60.186343, 24.8175143),
  );

  static Company rax = Company(
    id: 1,
    name: "Rax",
    logoPath: "assets/rax.png",
    rating: 3,
    location: "Central 00223, Espoo",
    phone: "+358 44-333-2123",
    website: "https://www.rax.com",
    latLng: LatLng(60.199143, 24.8029143),
  );
  static List<Deal> getExclusiveDeals() {
    return [
      Deal(
          id: 1,
          title: "25% OFF",
          description: "Exclusive Offer",
          imagePath: "assets/shoes_nike.png",
          company: nike,
          dealValidity: "15 Dec, 2018"),
      Deal(
          id: 2,
          title: "30% OFF",
          description: "Exclusive Offer",
          imagePath: "assets/pizza.png",
          company: rax,
          dealValidity: "20 Jan, 2021")
    ];
  }

  static List<Deal> getDeals() {
    return [
      Deal(
          id: 1,
          title: "25% OFF",
          description: "Exclusive Offer",
          imagePath: "assets/shoes_nike.png",
          company: nike,
          dealValidity: "15 Dec, 2018"),
      Deal(
          id: 2,
          title: "30% OFF",
          description: "Exclusive Offer",
          imagePath: "assets/shoes_nike.png",
          company: nike,
          dealValidity: "20 Jan, 2021"),
      Deal(
          id: 3,
          title: "75% Discount",
          description: "Premium Offer",
          imagePath: "assets/pizza.png",
          company: rax,
          dealValidity: "29 Nov, 2021")
    ];
  }

  static List<Interest> getInterests() {
    return [
      Interest(
        id: 0,
        title: "All",
      ),
      Interest(
        id: 1,
        title: "Shoes",
      ),
      Interest(id: 2, title: "T-Shirts")
    ];
  }
}
