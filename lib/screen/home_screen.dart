import 'package:clonecoding/repository/contents_repository.dart';
import 'package:clonecoding/screen/detail_screen.dart';
import 'package:clonecoding/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> datas = [];
  late String currentLocation;
  late ContentsRepository contentsRepository;
  final Map<String, String> locationTypeToString = {
    "ara": "아라동",
    "ora": "오라동",
    "donam": "도남동",
  };

  @override
  void initState() {
    super.initState();
    currentLocation = 'ara';
    contentsRepository = ContentsRepository();
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: PopupMenuButton<String>(
        onSelected: (String where) {
          setState(() {
            currentLocation = where;
          });
        },
        offset: Offset(0, 30),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(value: "ara", child: Text("아라동")),
            PopupMenuItem(value: "ora", child: Text("오라동")),
            PopupMenuItem(value: "donam", child: Text("도남동")),
          ];
        },
        child: Row(
          children: [
            Text(locationTypeToString[currentLocation]!),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      elevation: 1,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/svg/bell.svg",
            width: 22,
          ),
        ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> _loadContents() {
    return contentsRepository.loadContentsFromLocation(currentLocation);
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadContents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("해당 지역에 데이터가 없습니다."));
        }

        List<Map<String, dynamic>> datas =
            snapshot.data as List<Map<String, dynamic>>;

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (BuildContext context, int index) {
            final item = datas[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return DetailContentViewScreen(
                      data: Map<String, String>.from(datas[index]),
                    );
                  }),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: datas[index]["cid"].toString(),
                        child: Image.asset(
                          item["image"]!,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"]!,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              item["location"]!,
                              style: TextStyle(
                                fontSize: 12,
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              DataUtils.calcStringToWin(item["price"]!),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/heart_off.svg",
                                  width: 13,
                                  height: 13,
                                ),
                                SizedBox(width: 5),
                                Text(item["likes"]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 1,
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.4),
            );
          },
          itemCount: datas.length,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
