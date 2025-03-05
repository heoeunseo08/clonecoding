import 'package:carousel_slider/carousel_slider.dart';
import 'package:clonecoding/components/manor_temperature_widget.dart';
import 'package:clonecoding/repository/contents_repository.dart';
import 'package:clonecoding/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailContentViewScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const DetailContentViewScreen({
    super.key,
    required this.data,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DetailContentViewScreenState createState() =>
      _DetailContentViewScreenState();
}

class _DetailContentViewScreenState extends State<DetailContentViewScreen> {
  final ContentsRepository contentsRepository = ContentsRepository();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Size size;

  late List<String> imgList;
  late int _current;
  bool isMyFavoriteContent = false;

  @override
  void initState() {
    super.initState();
    imgList = [
      widget.data["image"],
      widget.data["image"],
      widget.data["image"],
      widget.data["image"],
      widget.data["image"],
    ];
    _current = 0;
    _loadMyFavoriteContentState();
  }

  _loadMyFavoriteContentState() async {
    bool ck = await contentsRepository.isMyFavoriteContents(widget.data["cid"]);
    setState(() {
      isMyFavoriteContent = ck;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  /*
  * appBar Widget 구현 
  */
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget _makeSliderImage() {
    return SizedBox(
      height: size.width * 0.8,
      child: Stack(
        children: [
          Hero(
            tag: widget.data["cid"],
            child: CarouselSlider(
              options: CarouselOptions(
                  height: size.width * 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: imgList.map((i) {
                return Container(
                  width: size.width,
                  height: size.width,
                  color: Colors.red,
                  child: Image.asset(
                    widget.data["image"],
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imgList.length, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Colors.white
                        // ignore: deprecated_member_use
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Container(
          //     width: 50,
          //     height: 50,
          //     child: Image.asset("assets/images/user.png"),
          //   ),
          // )
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset("assets/images/user.png").image,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "개발하는남자",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text("제주시 도담동"),
            ],
          ),
          Expanded(
            child: ManorTemperature(
              manorTemp: 37.3,
              mamorTemp: 0.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      // ignore: deprecated_member_use
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Text(
            widget.data["title"],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "디지털/가전 ∙ 22시간 전",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "선물받은 새상품이고\n상품 꺼내보기만 했습니다\n거래는 직거래만 합니다.",
            style: TextStyle(fontSize: 15, height: 1.5),
          ),
          SizedBox(height: 15),
          Text(
            "채팅 3 ∙ 관심 17 ∙ 조회 295",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _otherCellContents() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "판매자님의 판매 상품",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "모두보기",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildListDelegate(
          [
            _makeSliderImage(),
            _sellerSimpleInfo(),
            _line(),
            _contentDetail(),
            _line(),
            _otherCellContents(),
          ],
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          delegate: SliverChildListDelegate(List.generate(20, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.3),
                    height: 120,
                  ),
                ),
                Text(
                  "상품 제목",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "금액",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }).toList()),
        ),
      ),
    ]);
  }

  Widget _bottomBarWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              if (isMyFavoriteContent) {
                await contentsRepository
                    .deleteMyFavoriteContent(widget.data["cid"]);
              } else {
                await contentsRepository.addMyFavoriteContent(widget.data
                    .map((key, value) => MapEntry(key, value.toString())));
              }
              setState(() {
                isMyFavoriteContent = !isMyFavoriteContent;
              });
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(milliseconds: 1000),
                content: Text(
                    isMyFavoriteContent ? "관심목록에 추가됐어요." : "관심목록에서 제거됐어요."),
              ));
            },
            child: SvgPicture.asset(
              isMyFavoriteContent
                  ? "assets/svg/heart_on.svg"
                  : "assets/svg/heart_off.svg",
              width: 20,
              height: 20,
              // ignore: deprecated_member_use
              color: Color(0xfff08f4f),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 10),
            height: 40,
            width: 1,
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.3),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DataUtils.calcStringToWin(widget.data["price"]),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "가격제안불가",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xfff08f4f),
                  ),
                  child: Text(
                    "채팅으로 거래하기",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: _appbarWidget(),
        body: _bodyWidget(),
        bottomNavigationBar: _bottomBarWidget());
  }
}
