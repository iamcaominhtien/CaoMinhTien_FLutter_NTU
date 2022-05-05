import 'package:caominhtien_61cntt2/homework5/components/rss_item.dart';

class VNExpressRSSItem extends RSSItem {
  @override
  String getDescriprion(String rawDescription) {
    //9: Do dai cua pattern </a></br>
    int start = rawDescription.indexOf('</a></br>') + 9;
    if (start > 9) {
      return rawDescription.substring(start);
    }
    return "";
  }

  @override
  String? getImgUrl(String rawDescription) {
    //9 do dai cua pattern img src=""
    int start = rawDescription.indexOf('img src="') + 9;
    if (start > 9) {
      int end = rawDescription.indexOf('"', start);
      return rawDescription.substring(start, end);
    }
    return null;
  }
}
