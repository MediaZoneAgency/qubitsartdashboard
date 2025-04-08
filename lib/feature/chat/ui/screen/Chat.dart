import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qubitarts/core/helpers/extensions.dart';
import 'package:qubitarts/core/helpers/spacing.dart';
import 'package:qubitarts/feature/chat/logic/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/theming/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../post_details/ui/widget/suffixIcons.dart';
import '../../data/model/chat_model.dart';
import '../widgets/chat_bar.dart';
import '../widgets/chat_text_field.dart';
import '../widgets/search_bar.dart';
import '../widgets/support_bubble.dart';
import '../widgets/user_bubble.dart';
import 'conversation_chat.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ChatCubit.get(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.home_outlined, color: Colors.yellow),
            onPressed: () {

            },
          ),
          title: Text(
            "Chat",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),


        body: ListView(
              children: [
        SearchBarWidget(
          controller: TextEditingController(),
          onSearch: (query) {
            // Handle search logic here
          },
        ),

        BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {

            return  FutureBuilder<List<ChatModel>>(
                future: ChatCubit.get(context).getActiveChats(),
                builder: (context, snapshot) {
                  print("📡 FutureBuilder Connection State: ${snapshot.connectionState}");
                  print("📊 Future Data: ${snapshot.data}");

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No Chats Available", style: TextStyle(color: Colors.white)));
                  }

                  final chats = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics:ScrollPhysics(),
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];

                      return FutureBuilder<Map<String, dynamic>?>(
                        future:ChatCubit.get(context).getUserData(chat.userA), // جلب بيانات userA
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData || snapshot.data == null) {
                            return SizedBox(); // لا تعرض أي شيء إذا لم يتم العثور على المستخدم
                          }

                          final userData = snapshot.data!;
                          return SizedBox(
                            height: 70.h,
                            child: ChatTile(
                              chat: chat,
                              userName: userData['name'] ?? 'Unknown',
                              userAvatar: userData['avatar'] ?? 'assets/default_avatar.png',
                            ),
                          );
                        },
                      );
                    },
                  );

                },
              );


          },
        ),
              ])),
    );
  }
}

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final String userName;
  final String userAvatar;

  const ChatTile({
    Key? key,
    required this.chat,
    required this.userName,
    required this.userAvatar,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConversationScreen(),
            ),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(userAvatar),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    style: TextStyle(
                      color: chat.lastMessageSeenBy.contains(chat.userA)
                          ? Colors.grey
                          : Colors.yellow,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




