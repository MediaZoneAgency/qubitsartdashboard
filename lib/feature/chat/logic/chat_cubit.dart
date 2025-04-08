import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:qubitarts/feature/chat/data/model/user_msg_model.dart';
import 'package:qubitarts/feature/chat/data/repo/chat_repo.dart';

import '../../../core/db/cash_helper.dart';
import '../data/model/chat_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  List<UserMsgModel> msgList = [];
  Future<List<ChatModel>> getActiveChats() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('chats').get();

      List<ChatModel> chats = querySnapshot.docs
          .map((doc) => ChatModel.fromDocument(doc))
          .toList();

      // جلب بيانات userA لكل محادثة
      List<ChatModel> updatedChats = await Future.wait(
        chats.map((chat) => fetchChatWithUserData(chat)),
      );

      return updatedChats;
    } catch (e) {
      print("Error fetching chats: $e");
      return [];
    }
  }


  Future<Map<String, dynamic>?> getUserData(String userPath) async {
    if (userPath.isEmpty) return null; // ✅ تفادي الخطأ مبكرًا

    int retryCount = 0;
    const int maxRetries = 3;
    const Duration retryDelay = Duration(seconds: 2);

    while (retryCount < maxRetries) {
      try {
        String userId = userPath.split('/').last;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          return userDoc.data() as Map<String, dynamic>;
        } else {
          return null;
        }
      } catch (e) {
        print("Error fetching user data (Attempt $retryCount): $e");

        if (e.toString().contains('unavailable')) {
          retryCount++;
          await Future.delayed(retryDelay);
        } else {
          return null; // أخطاء أخرى غير متعلقة بالشبكة
        }
      }
    }
    return null;
  }


  Future<ChatModel> fetchChatWithUserData(ChatModel chat) async {
    try {
      // جلب بيانات userA باستخدام المسار المخزن في الدردشة
      Map<String, dynamic>? userData = await getUserData(chat.userA);

      if (userData != null) {
        return chat.copyWith(
          userName: userData['name'] ?? 'Unknown',
          userAvatar: userData['avatar'] ?? 'assets/default_avatar.png',
        );
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return chat; // إرجاع نفس الدردشة في حال فشل الجلب
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserMsgModel>> getChatMessages(String chatId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('chat_messages')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true) // Sort by latest messages
          .get();

      return querySnapshot.docs.map((doc) {
        return UserMsgModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching chat messages: $e");
      return [];
    }
  }
}

