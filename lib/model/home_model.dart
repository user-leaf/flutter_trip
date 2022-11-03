import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/search_page.dart';

import 'grid_nav_model.dart';

class HomeModel {
  final ConfigModel? config;
  final List<CommonModel>? bannerList;
  final List<CommonModel>? localNavList;
  final List<CommonModel>? subNavList;
  final GridNavModel? gridNav;
  final SalesBoxModel? salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.gridNav,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((e) => CommonModel.fromJson((e))).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((e) => CommonModel.fromJson((e))).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((e) => CommonModel.fromJson((e))).toList();

    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }
}
