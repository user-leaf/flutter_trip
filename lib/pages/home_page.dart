import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://t7.baidu.com/it/u=4162611394,4275913936&fm=193&f=GIF',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fphoto%2F2010-6-27%2Fenterdesk.com-7C611E1841DFE48E22746AB85D6334A5.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1669427149&t=5a25a4c5a3ec22440d345de0a13fe8c7',
    'https://img2.baidu.com/it/u=3753365871,1143524046&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
