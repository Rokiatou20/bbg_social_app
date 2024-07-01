import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_drive/app_setup.dart';

import 'package:test_drive/configuration/colors.dart';
import 'package:test_drive/data/models/conversation/conversation.dart';
import 'package:test_drive/data/models/session/session.dart';

import '../../data/models/user/user.dart';

class ConversationItemWidget extends StatelessWidget {

  final Conversation conversation;
  final Function () onTap;
  const ConversationItemWidget({super.key, required this.conversation, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
        leading: Stack(
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle
              ),
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              top: Adaptive.h(5),
              start: Adaptive.w(3),
              child: Container(
                width: Adaptive.w(4),
                height: Adaptive.h(4),
                decoration: BoxDecoration(
                  color: conversation.isConnected() == true ? AppColors.connectedUserColor : AppColors.unConnectedUserColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0
                  )
                ),
              ),
            )
          ],
        ),
        title: Text(
            conversation.senderName(User()) ?? 'Unknown Sender',
            style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        subtitle: Text(conversation.messageContent() ?? 'No message', maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Column(
          children: [
             Text(
                conversation.lastMessageDate != null ? intl.DateFormat("Hm").format(conversation.lastMessageDate()!) : 'No message',
                style: const TextStyle(
                color: AppColors.conversationDateColor
            )),
            Offstage(
              offstage: conversation.unReadCount() == 0,
              child: Container(
                width: Adaptive.w(9),
                height: Adaptive.h(2.5),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20)
                ),
                child:  Center(
                  child: Text(
                    conversation.unReadCount().toString(),
                    style: const TextStyle(
                      color: AppColors.appBarTitleColor
                    ),
                  ),
                )
              ),
            )
          ],
        ),
      );
  }
}
