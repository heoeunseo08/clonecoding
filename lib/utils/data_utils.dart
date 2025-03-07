import 'package:intl/intl.dart';

class DataUtils {
  static final oCcy = NumberFormat("###,###", "ko_KR");
  static String calcStringToWin(String priceString) {
    if (priceString == "무료나눔") {
      return priceString;
    }
    return "${oCcy.format(int.parse(priceString))} 원";
  }
}
