import 'package:clonecoding/repository/contents_repository.dart';
import 'package:clonecoding/screen/detail_screen.dart';
import 'package:clonecoding/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyFavoriteContentScreen extends StatefulWidget {
  const MyFavoriteContentScreen({super.key});

  @override
  State<MyFavoriteContentScreen> createState() =>
      _MyFavoriteContentScreenState();
}

class _MyFavoriteContentScreenState extends State<MyFavoriteContentScreen> {
  late ContentsRepository contentsRepository;

  @override
  void initState() {
    super.initState();
    contentsRepository = ContentsRepository();
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: const Text(
        '관심 목록',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _makeDataList(List<Map<String, String>> datas) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        final item = datas[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return DetailContentViewScreen(
                  data: Map<String, String>.from(datas[index]),
                  key: UniqueKey(),
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
                    tag: item["cid"].toString(),
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
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item["location"]!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DataUtils.calcStringToWin(item["price"]!),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/heart_off.svg",
                              width: 13,
                              height: 13,
                            ),
                            const SizedBox(width: 5),
                            Text(item["likes"]!),
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
          color: Colors.black.withOpacity(0.4),
        );
      },
      itemCount: datas.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // 내부 스크롤 방지
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _loadMyFavoriteContentsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("데이터 오류"));
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text("해당 지역에 데이터가 없습니다."));
        }

        return _makeDataList(
            snapshot.data!.map((item) => item.cast<String, String>()).toList());
      },
    );
  }

  Future<List<Map<String, dynamic>>> _loadMyFavoriteContentsList() async {
    return (await contentsRepository.loadFavoriteContents())
        .cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
