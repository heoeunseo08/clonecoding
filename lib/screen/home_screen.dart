import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required String title,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> datas = [];
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
    datas = [
      {
        "image": "assets/images/ara-1.jpg",
        "title": "네메시스 축구화",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "2",
      },
      {
        "image": "assets/images/ara-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "제주 제주시 아라동",
        "price": "100000",
        "likes": "5",
      },
      {
        "image": "assets/images/ara-3.jpg",
        "title": "치약 팝니다.",
        "location": "제주 제주시 아라동",
        "price": "5000",
        "likes": "0",
      },
      {
        "image": "assets/images/ara-4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
        "location": "제주 제주시  아라동",
        "price": "2500000",
        "likes": "6",
      },
      {
        "image": "assets/images/ara-5.jpg",
        "title": "디월트존기임팩",
        "location": "제주 제주시  아라동",
        "price": "150000",
        "likes": "2",
      },
      {
        "image": "assets/images/ara-6.jpg",
        "title": "갤럭시s10",
        "location": "제주 제주시  아라동",
        "price": "180000",
        "likes": "2",
      },
      {
        "image": "assets/images/ara-7.jpg",
        "title": "선반",
        "location": "제주 제주시  아라동",
        "price": "15000",
        "likes": "2",
      },
      {
        "image": "assets/images/ara-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "제주 제주시  아라동",
        "price": "80000",
        "likes": "3",
      },
      {
        "image": "assets/images/ara-9.jpg",
        "title": "대우 미니냉장고",
        "location": "제주 제주시  아라동",
        "price": "30000",
        "likes": "3",
      },
      {
        "image": "assets/images/ara-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "제주 제주시  아라동",
        "price": "50000",
        "likes": "7",
      },
    ];
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          // ignore: avoid_print
          print('Home Screen');
        },
        child: Row(
          children: [
            const Text('Home Screen'),
            Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
      ),
      elevation: 1,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.tune),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/svg/bell.svg',
            width: 22,
          ),
        ),
      ],
    );
  }

  final oCcy = NumberFormat("###,###", "ko_KR");

  String calcStringToWin(String priceString) {
    return "${oCcy.format(int.parse(priceString))} 원";
  }

  Widget _bodyWidget() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10),
      // ignore: no_leading_underscores_for_local_identifiers
      itemBuilder: (BuildContext _context, int index) {
        // ignore: avoid_unnecessary_containers
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    datas[index]["image"].toString(),
                    width: 100,
                    height: 100,
                  ),
                ),
                // ignore: avoid_unnecessary_containers
                Expanded(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datas[index]["title"].toString(),
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          datas[index]["location"].toString(),
                          style: TextStyle(
                            fontSize: 12,
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          calcStringToWin(datas[index]["price"].toString()),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/heart_off.svg",
                              width: 13,
                              height: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(datas[index]["likes"].toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.4),
        );
      },
      itemCount: 10,
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      {required String iconname, required String label}) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: SvgPicture.asset(
            "assets/svg/${iconname}_off.svg",
            width: 22,
          ),
        ),
        label: label);
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      currentIndex: _currentPageIndex,
      items: [
        _bottomNavigationBarItem(
          iconname: "home",
          label: "홈",
        ),
        _bottomNavigationBarItem(
          iconname: "notes",
          label: "동네생활",
        ),
        _bottomNavigationBarItem(
          iconname: "location",
          label: "내 근처",
        ),
        _bottomNavigationBarItem(
          iconname: "chat",
          label: "채팅",
        ),
        _bottomNavigationBarItem(
          iconname: "user",
          label: "나의 당근",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
