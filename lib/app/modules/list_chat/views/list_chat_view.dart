import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import '../../../services/user_service.dart';

import '../../../styles/styles.dart';
import '../controllers/list_chat_controller.dart';

class ListChatView extends GetView<ListChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'.tr, style: Styles.appBarTextStyle),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        builder: (context, snapshot) {
          print(snapshot.data.toString());
          log(snapshot.data.toString());
          if (!snapshot.hasData || (snapshot.data?.isEmpty ?? false)) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Text('No Chat'.tr),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Room? room = snapshot.data?[index];
              print("ALEX  $room");
              return InkWell(
                onTap: () {
                  Get.toNamed('/chat', arguments: room);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      _buildAvatar(room),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        room?.name ?? '',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAvatar(types.Room? room) {
    var color = Colors.transparent;

    if (room?.type == types.RoomType.direct) {
      try {
        final otherUser = room?.users.firstWhere(
          (u) => u.id != UserService().currentUser?.uid,
        );
        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found
      }
    }

    final hasImage = room?.imageUrl != null;
    final name = room?.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(room?.imageUrl ?? "") : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  static const colors = [
    Color(0xffff6767),
    Color(0xff66e0da),
    Color(0xfff5a2d9),
    Color(0xfff0c722),
    Color(0xff6a85e5),
    Color(0xfffd9a6f),
    Color(0xff92db6e),
    Color(0xff73b8e5),
    Color(0xfffd7590),
    Color(0xffc78ae5),
  ];

  Color getUserAvatarNameColor(types.User? user) {
    final index = (user?.id.hashCode ?? 0) % colors.length;
    return colors[index];
  }

  String getUserName(types.User? user) =>
      '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim();
}
