// // import 'message_model.dart';
// //
// // class Chat {
// //   String id;
// //   String name;
// //   List<MessageModel> messages;
// //   MessageModel? lastMessage;
// //
// //   Chat({
// //     required this.id,
// //     required this.name,
// //     required this.messages,
// //     this.lastMessage,
// //   });
// // }
//
// FutureBuilder<MessageModel?>(
// future: getLastReceivedMessage(
// senderEmail: email,
// recipientEmail: user.email!,
// ),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// // Return a placeholder widget while fetching the last message
// return CircularProgressIndicator();
// } else if (snapshot.hasData) {
// final lastMessage = snapshot.data!.message;
// return FutureBuilder<int>(
// future: getLastMessageNumber(
// senderEmail: email,
// recipientEmail: user.email!,
// ),
// builder: (context, numberSnapshot) {
// if (numberSnapshot.hasData) {
// final unreadCount = numberSnapshot.data!;
// return ChatItem(
// onTap: () {
// BlocProvider.of<ChatCubit>(context).getMessage(
// recipientEmail: user.email!,
// senderEmail: email,
// );
// Navigator.pushNamed(context, MessageScreen.id, arguments: user);
// },
// sender: user.userName!,
// lastMessage: lastMessage ?? '', // Use the actual last message
// unreadCount: unreadCount, // Use the actual unread count
// );
// } else {
// return Container();
// }
// },
// );
// } else {
// return Container();
// }
// },
// )
// : Container();


// void sendMessage({required String message,required String email}){
//   try{
//     Messages.add(
//         {
//           "message": message,
//           "createdAt" : DateTime.now(),
//           "id" : email
//         }
//     );
//   }
//   on Exception catch(e) {}
// }
//
//
// void getMessage(){
//   Messages.orderBy("createdAt",descending: true).snapshots().listen((event) {
//
//     messagesList.clear();
//
//     for (var doc in event.docs){
//       messagesList.add(MessageModel.fromjson(doc));
//     }
//
//     emit(ChatSuccessState(messages: messagesList));
//
//   });
// }


// void sendMessage({required String message, required String senderEmail, required String recipientEmail}) {
//   try {
//     Messages.add(
//       {
//         "message": message,
//         "createdAt": DateTime.now(),
//         "senderEmail": senderEmail,
//         "recipientEmail": recipientEmail,
//       },
//     );
//   } catch (e) {
//     // Handle the exception
//   }
// }
//
// void getMessage() {
//   Messages.orderBy('createdAt', descending: true)
//       .snapshots()
//       .listen((event) {
//
//     messagesList.clear();
//
//     for (var doc in event.docs) {
//       messagesList.add(MessageModel.fromjson(doc.data()));
//
//     }
//
//     emit(ChatSuccessState(messages: messagesList));
//   });
// }


// void sendMessage({required String message, required String senderEmail, required String recipientEmail}) {
//   try {
//     chats.doc(senderEmail)
//         .collection('messages')
//         .add({
//       "message": message,
//       "createdAt": DateTime.now(),
//       "senderEmail": senderEmail,
//       "recipientEmail": recipientEmail,
//     })
//         .then((value) {
//       emit(ChatSendSuccessState());
//     })
//         .catchError((error) {
//       emit(ChatErrorState(error.toString()));
//     });
//   } catch (e) {
//     emit(ChatErrorState(e.toString()));
//   }
// }
//
// void getMessage({String? senderEmail, String? recipientEmail}) {
//   chats.doc(senderEmail)
//       .collection('messages')
//       .orderBy('createdAt', descending: true)
//       .snapshots()
//       .listen((event) {
//     messagesList.clear();
//
//     for (var doc in event.docs) {
//       messagesList.add(MessageModel.fromjson(doc.data()));
//     }
//
//     emit(ChatSuccessState(messages: messagesList));
//   });
// }

// void getMessage({String? senderEmail,String? recipientEmail}) {
//   Messages
//       .where('senderEmail', isEqualTo: senderEmail)
//       .where('recipientEmail', isEqualTo: recipientEmail)
//       .orderBy('createdAt', descending: true)
//       .snapshots()
//       .listen((event) {
//     messagesList.clear();
//
//     for (var doc in event.docs) {
//       messagesList.add(MessageModel.fromjson(doc.data()));
//
//     }
//
//     emit(ChatSuccessState(messages: messagesList));
//   });
// }