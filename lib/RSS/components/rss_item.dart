abstract class RSSItem {
  String? title;
  String? pubDate;
  String? description;
  String? link;
  String? imgUrl;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'pubDate': pubDate,
      'description': description,
      'link': link,
      'imgUrl': imgUrl,
    };
  }

  RSSItem getRSSFromJson(Map<String, dynamic> json) {
    title = json['title'];
    pubDate = json['pubDate'];
    description = json['description'];
    link = json['link'];
    imgUrl = json['imgUrl'];
    return this;
  }

  String getDescriprion(String rawDescription);
  String? getImgUrl(String rawDescription);
}
