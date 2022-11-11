import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/utils/NavigatorUtil.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/webview.dart';

import '../model/sales_box_model.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;

  String resultString = "";
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNavModel? gridNavModel;
  SalesBoxModel? salesBoxModel;
  bool _loading = true;

  get _appBar {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 90.0,
            decoration: BoxDecoration(
                color:
                    Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
            child: GestureDetector(
              onTap: () {
                _jumpToSearch;
              },
              child: SearchBar(
                  searchBarType: appBarAlpha > 0.2
                      ? SearchBarType.homeLight
                      : SearchBarType.home,
                  defaultText: SEARCH_BAR_DEFAULT_TEXT,
                  leftButtonClick: () {},
                  speakClick: _jumpToSpeak,
                  inputBoxClick: () {}),
            ),
          ),
        ),
      ],
    );
  }

  get _banner => Container(
        height: 160,
        child: Swiper(
          itemCount: bannerList.length,
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  CommonModel model = bannerList[index];
                  return WebView(
                    url: model.url,
                    title: model.title,
                    hideAppBar: model.hideAppBar,
                  );
                }));
              },
              child: Image.network(
                bannerList[index].icon,
                fit: BoxFit.fill,
              ),
            );
          },
          pagination: SwiperPagination(),
        ),
      );

  get _jumpToSpeak => null;

  get _jumpToSearch {
    Future.delayed(Duration(milliseconds: 500), () {
      NavigatorUtil.push(context, SearchPage(hideLeft: false));
    });
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  void _onScroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  Future<Null> _handleRefresh() async {
    // HomeDao.fetch().then((result) {
    //   setState(() {
    //     resultString = jsonEncode(result);
    //   });
    // }).catchError((e) {
    //   setState(() {
    //     resultString = e.toString();
    //   });
    // });

    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        // resultString = jsonEncode(model);
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: [
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: RefreshIndicator(
                  onRefresh: _handleRefresh, // why?
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0) {
                        //滚动且是列表滚动的时候
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                      return false;
                    },
                    child: _listView,
                  ),
                ),
              ),
              _appBar
            ],
          )),
    );
  }

  Widget get _listView {
    return ListView(
      children: [
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(
            localNavList: localNavList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(
            gridNavModel: gridNavModel,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }
}
