import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/local_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;

  List _imageUrls = [
    'https://t7.baidu.com/it/u=4162611394,4275913936&fm=193&f=GIF',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fphoto%2F2010-6-27%2Fenterdesk.com-7C611E1841DFE48E22746AB85D6334A5.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1669427149&t=5a25a4c5a3ec22440d345de0a13fe8c7',
    'https://img2.baidu.com/it/u=3753365871,1143524046&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
  ];

  String resultString = "";
  List<CommonModel>? localNavList = [];

  @override
  void initState() {
    super.initState();
    loadData();
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

  loadData() async {
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
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return false;
              },
              child: ListView(
                children: [
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                    child: LocalNav(
                      localNavList: localNavList!,
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text('resultString'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
