import 'package:caominhtien_61cntt2/fcm/message.dart';
import 'package:caominhtien_61cntt2/fcm/message_helper.dart';
import 'package:flutter/material.dart';

class PageListMessage extends StatefulWidget {
  const PageListMessage({Key? key}) : super(key: key);

  @override
  State<PageListMessage> createState() => _PageListMessageState();
}

class _PageListMessageState extends State<PageListMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Messages'),
      ),
      body: FutureBuilder<List<MyNotificationMessage>?>(
        future: MessageHelper.readMessage(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Có lỗi xảy ra'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Không có dữ liệu'),
            );
          }

          List<MyNotificationMessage>? listMessage = snapshot.data;
          return ListView.separated(
            itemBuilder: ((context, index) {
              return ListTile(
                leading: Text(listMessage?[index].from ?? "Unknown"),
                title: Text(listMessage?[index].title ?? "No title"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(listMessage?[index].body ?? 'No body'),
                    Text(listMessage?[index].time ?? 'Unknown'),
                  ],
                ),
              );
            }),
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 1,
            ),
            itemCount: listMessage?.length ?? 0,
          );
        },
      ),
    );
  }
}
