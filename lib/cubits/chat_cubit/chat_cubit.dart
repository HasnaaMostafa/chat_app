import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  List<MessageModel> messagesList = [];
  List<UserModel> userList = [];
  UserModel? userModel;

  CollectionReference Messages =
      FirebaseFirestore.instance.collection("messages");

  void sendMessage(
      {required String message,
      required String senderEmail,
      required String recipientEmail}) {
    try {
      Messages.doc(senderEmail)
          .collection('chats')
          .doc(recipientEmail)
          .collection('messages')
          .add({
        "message": message,
        "createdAt": DateTime.now(),
        "senderEmail": senderEmail,
        "recipientEmail": recipientEmail,
      }).then((value) {
        Messages.doc(recipientEmail)
            .collection('chats')
            .doc(senderEmail)
            .collection('messages')
            .add({
              "message": message,
              "createdAt": DateTime.now(),
              "senderEmail": senderEmail,
              "recipientEmail": recipientEmail,
            })
            .then((value) {})
            .catchError((error) {
              emit(ChatErrorState(error.toString()));
            });
      }).catchError((error) {
        emit(ChatErrorState(error.toString()));
      });
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  void getMessage({String? senderEmail, String? recipientEmail}) {
    Messages.doc(senderEmail)
        .collection('chats')
        .doc(recipientEmail)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      messagesList.clear();

      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromjson(doc.data()));
      }

      emit(ChatSuccessState(
        messages: messagesList,
      ));
    });
  }

  void getUsers({String? senderEmail}) async {
    emit(GetUserLoadingState());

    await FirebaseFirestore.instance
        .collection("users")
        .orderBy("uId")
        .get()
        .then((querySnapshot) {
      //
      // querySnapshot.docs.forEach((element) {
      //   if(element.data()["email"] != senderEmail){
      //     userList.add(UserModel.fromJson(element.data()));
      //   }
      // });
      userList.clear();

      for (var doc in querySnapshot.docs) {
        if (doc.data()["email"] != senderEmail) {
          userList.add(UserModel.fromJson(doc.data()));
        }
      }
      emit(GetUserSuccessState(users: userList));
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  Future<MessageModel?> getLastReceivedMessage(
      {String? senderEmail, String? recipientEmail}) async {
    final snapshot = await Messages.doc(recipientEmail)
        .collection('chats')
        .doc(senderEmail)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final lastMessageDoc = snapshot.docs.first;
      return MessageModel.fromjson(lastMessageDoc.data());
    }

    return null;
  }

  Future<int> getLastMessageNumber(
      {String? senderEmail, String? recipientEmail}) async {
    final snapshot = await Messages.doc(recipientEmail)
        .collection('chats')
        .doc(senderEmail)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final lastMessageDoc = snapshot.docs.first;
      final lastMessageNumber = lastMessageDoc.data()['messageNumber'];

      if (lastMessageNumber is int) {
        return lastMessageNumber;
      }
    }

    return 0;
  }
}
