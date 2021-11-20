import 'package:HMSFlutter/core/models/Company.dart';
import 'package:HMSFlutter/core/models/Deal.dart';
import 'package:HMSFlutter/core/models/Interest.dart';
import 'package:flutter/foundation.dart';
import 'package:huawei_map/map.dart';

class MainViewModel extends ChangeNotifier {
  MainViewModel() {
    Company nike = Company(
      id: 1,
      name: "Nike",
      logoPath: "assets/nike.png",
      rating: 4.8,
      location: "Rastila 02600, Helsinki",
      phone: "+358 532-512-5125",
      website: "https://www.nike.com",
      latLng: LatLng(60.186343, 24.8175143),
    );

    Company rax = Company(
      id: 2,
      name: "Rax",
      logoPath: "assets/rax.png",
      rating: 3,
      location: "Central 00223, Espoo",
      phone: "+358 44-333-2123",
      website: "https://www.rax.com",
      latLng: LatLng(60.199143, 24.8029143),
    );

    final exclusiveDeal1 = Deal(
      id: 1,
      title: "25% OFF",
      description: "Exclusive Offer",
      imagePath: "assets/shoes_nike.png",
      companyId: nike.id,
      dealValidity: "15 Dec, 2018",
      isExclusive: true,
    );
    final exclusiveDeal2 = Deal(
      id: 2,
      title: "30% OFF",
      description: "Exclusive Offer",
      imagePath: "assets/pizza.png",
      companyId: rax.id,
      dealValidity: "20 Jan, 2021",
      isExclusive: true,
    );

    final deal1 = Deal(
        id: 1,
        title: "25% OFF",
        description: "Exclusive Offer",
        imagePath: "assets/shoes_nike.png",
        companyId: nike.id,
        dealValidity: "15 Dec, 2018");
    final deal2 = Deal(
        id: 2,
        title: "30% OFF",
        description: "Exclusive Offer",
        imagePath: "assets/shoes_nike.png",
        companyId: nike.id,
        dealValidity: "20 Jan, 2021",
        isApplied: true);
    final deal3 = Deal(
        id: 3,
        title: "75% Discount",
        description: "Premium Offer",
        imagePath: "assets/pizza.png",
        companyId: rax.id,
        dealValidity: "29 Nov, 2021");

    final interest1 = Interest(
      id: 0,
      title: "All",
    );
    final interest2 = Interest(
      id: 1,
      title: "Shoes",
    );
    final interest3 = Interest(id: 2, title: "T-Shirts");
    _companies = [nike, rax];
    _deals = [deal1, deal2, deal3, exclusiveDeal1, exclusiveDeal2];
    _interests = [interest1, interest2, interest3];
  }

  late List<Company> _companies;
  late List<Deal> _deals;
  late List<Interest> _interests;
  List<Deal> getExclusiveDeals() {
    return _deals.where((deal) => deal.isExclusive).toList();
  }

  List<Deal> getDeals() {
    return _deals.where((deal) => !deal.isExclusive).toList();
  }

  List<Interest> getInterests() {
    return _interests;
  }

  List<Company> getCompanies() {
    return _companies;
  }

  Company getCompanyById(int companyId) {
    return _companies.firstWhere((element) => element.id == companyId);
  }

  void toggleCompanyLike(Company company) {
    _companies.firstWhere((item) => item.id == company.id).isLiked =
        !company.isLiked;
    notifyListeners();
  }

  void claimOffer(Deal deal) {
    _deals.firstWhere((item) => item.id == deal.id).isApplied = true;
    notifyListeners();
  }
}
