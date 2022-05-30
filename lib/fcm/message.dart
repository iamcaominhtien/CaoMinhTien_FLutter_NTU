class MyNotificationMessage {
  String? title, body, from, time;

  MyNotificationMessage({this.title, this.body, this.from, this.time});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'from': from,
      'time': time,
    };
  }

  factory MyNotificationMessage.fromJson(Map<String, dynamic> json) {
    return MyNotificationMessage(
      title: json['title'],
      body: json['body'],
      from: json['body'],
      time: json['time'],
    );
  }
}
