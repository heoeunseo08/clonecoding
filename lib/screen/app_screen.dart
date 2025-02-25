import 'package:clonecoding/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({
    super.key,
    required String title,
  });

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  List<Map<String, String>> datas = [];
  late int _currentPageIndex;

  final oCcy = NumberFormat("###,###", "ko_KR");

  String calcStringToWin(String priceString) {
    return "${oCcy.format(int.parse(priceString))} 원";
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
        activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconname}_on.svg",
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
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _appbarWidget(),
      body: Builder(
        builder: (context) {
          switch (_currentPageIndex) {
            case 0:
              return HomeScreen();
            case 1:
              return Container(
                child: Text("동네 생활"),
              );
            case 2:
              return Container(
                child: Text("내 근처"),
              );
            case 3:
              return Container(
                child: Text("채팅"),
              );
            case 4:
              return Container(
                child: Text("나의 당근"),
              );
            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
