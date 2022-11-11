import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/utils/NavigatorUtil.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/webview.dart';

const TYPES = [
  'channelgroup',
  'channelgs',
  'channelplane',
  'channeltrain',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup',
];

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String? keyword;
  final String? hint;
  final String? defaultText;

  const SearchPage(
      {super.key,
      required this.hideLeft,
      this.keyword = '',
      this.hint = 'hint',
      this.defaultText = 'defaultText'});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showText = '';
  String keyword = '';
  SearchModel? searchModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          // MediaQuery.removePadding(
          //   removeTop: true,
          //   context: context,
          //   child: Expanded(
          //     flex: 1,
          //     child: ListView.builder(
          //         itemCount: searchModel?.data?.length ?? 0,
          //         itemBuilder: (context, position) {
          //           return _item(position);
          //         }),
          //   ),
          // ),

          // InkWell(
          //   onTap: () {
          //     String url =
          //         'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';
          //     Map<String, dynamic> canshu = {
          //       'source': 'mobileweb',
          //       'action': 'autocomplete',
          //       'contentType': 'json',
          //       'keyword': keyword,
          //     };
          //     Uri uri = Uri(
          //         scheme: 'https',
          //         host: 'm.ctrip.com',
          //         path: '/restapi/h5api/searchapp/search',
          //         queryParameters: canshu);
          //     SearchDao.fetch(uri).then((value) {
          //       setState(() {
          //         showText = value.data[0].url;
          //       });
          //     }).catchError((e) {
          //       print(e);
          //     });
          //   },
          //   child: Text(
          //     'Get',
          //     style: TextStyle(fontSize: 20),
          //   ),
          // ),
          // Text(showText),

          Container(
            child:
                RichText(text: TextSpan(children: _title('我来自中国，我是中国人', '中国'))),
          ),
        ],
      ),
    );
  }

  _onTextChanged(String text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    Map<String, dynamic> canshu = {
      'source': 'mobileweb',
      'action': 'autocomplete',
      'contentType': 'json',
      'keyword': keyword,
    };
    Uri uri = Uri(
        scheme: 'https',
        host: 'm.ctrip.com',
        path: '/restapi/h5api/searchapp/search',
        queryParameters: canshu);
    SearchDao.fetch(uri, text).then((value) {
      // 只有当当前输入的内容和服务端返回的内容一致时才渲染
      if (value.keyword == keyword) {
        setState(() {
          showText = value.data[0].url;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  _appBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x66000000), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 90),
        child: SearchBar(
          enabled: true,
          hideLeft: widget.hideLeft,
          searchBarType: SearchBarType.normal,
          hint: widget.hint,
          defaultText: widget.defaultText ?? '',
          leftButtonClick: () {
            Navigator.pop(context);
          },
          rightButtonClick: () {},
          speakClick: () {},
          inputBoxClick: () {},
          onChanged: _onTextChanged,
        ),
      ),
    );
  }

  _item(int position) {
    if (searchModel == null || searchModel?.data == null) return null;
    SearchItem? item = searchModel?.data[position];
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context, WebView(url: item?.url, title: '详情'));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                  height: 26,
                  width: 26,
                  image: AssetImage(_typeImage(item?.type))),
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  child: Text(
                      '${item?.word} ${item?.districtname ?? ''} ${item?.zonename ?? ''}'),
                ),
                Container(
                  width: 300,
                  child: Text('${item?.price ?? ''} ${item?.type ?? ''}'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _typeImage(String? type) {
    if (type == null) return 'images/type_travelgroup.png';
    String path = 'travelgroup';
    for (String val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  _title(String word, String keyword) {
    // 'wordwoc' -> [, ord, oc]
    List<TextSpan> spans = [];
    TextStyle normalStyle = TextStyle(color: Colors.black);
    TextStyle keywordStyle = TextStyle(color: Colors.orange);
    String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    List<String> arr = word.toLowerCase().split(keyword.toLowerCase());
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        //搜索关键字高亮忽略大小写
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keyword.length),
            style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
