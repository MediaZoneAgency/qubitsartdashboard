import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final String lastMessage;
  final String lastMessageSentBy;
  final Timestamp lastMessageTime;
  final List<String> lastMessageSeenBy;
  final String userA;
  final String? userB; // جعل userB اختيارياً
  final List<String> users;
  final String? userName;
  final String? userAvatar;

  ChatModel({
    required this.id,
    required this.lastMessage,
    required this.lastMessageSentBy,
    required this.lastMessageTime,
    required this.lastMessageSeenBy,
    required this.userA,
    this.userB, // يمكن أن يكون `null`
    required this.users,
    this.userName,  // **إضافة اسم المستخدم**
    this.userAvatar,
  });

  /// ✅ **تحويل من Firestore Document إلى كائن `ChatModel`**
  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ChatModel(
      id: doc.id,
      lastMessage: data['last_message'] ?? '',
      lastMessageSentBy: (data['last_message_sent_by'] as DocumentReference?)?.id ?? '',
      lastMessageTime: data['last_message_time'] ?? Timestamp.now(),

      // التعامل مع مشكلة last_message_seen_by
      lastMessageSeenBy: data['last_message_seen_by'] is List
          ? (data['last_message_seen_by'] as List<dynamic>)
          .map((e) => (e as DocumentReference?)?.id ?? '')
          .where((id) => id.isNotEmpty)
          .toList()
          : (data['last_message_seen_by'] is DocumentReference)
          ? [(data['last_message_seen_by'] as DocumentReference).id]
          : [],

      userA: (data['user_a'] as DocumentReference?)?.id ?? '',
      userB: (data['user_b'] as DocumentReference?)?.id ?? '',

      users: (data['users'] as List<dynamic>?)
          ?.map((e) => (e as DocumentReference?)?.id ?? '')
          .where((id) => id.isNotEmpty)
          .toList() ??
          [],
    );
  }

  ChatModel copyWith({
    String? id,
    String? lastMessage,
    String? lastMessageSentBy,
    Timestamp? lastMessageTime,
    List<String>? lastMessageSeenBy,
    String? userA,
    String? userB,
    List<String>? users,
    String? userName,  // **إضافة `userName`**
    String? userAvatar,

  }) {
    return ChatModel(
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSentBy: lastMessageSentBy ?? this.lastMessageSentBy,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastMessageSeenBy: lastMessageSeenBy ?? this.lastMessageSeenBy,
      userA: userA ?? this.userA,
      userB: userB ?? this.userB,
      users: users ?? this.users,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
    );
  }


  /// ✅ **تحويل الكائن إلى `Map` لحفظه في Firestore**
  Map<String, dynamic> toMap() {
    return {
      'last_message': lastMessage,
      'last_message_sent_by': FirebaseFirestore.instance.collection('users').doc(lastMessageSentBy),
      'last_message_time': lastMessageTime,
      'last_message_seen_by': lastMessageSeenBy.map((id) => FirebaseFirestore.instance.collection('users').doc(id)).toList(),
      'user_a': FirebaseFirestore.instance.collection('users').doc(userA),
      if (userB != null) 'user_b': FirebaseFirestore.instance.collection('users').doc(userB!), // حفظ `userB` فقط إذا لم يكن `null`
      'users': users.map((id) => FirebaseFirestore.instance.collection('users').doc(id)).toList(),
    };
  }
}

