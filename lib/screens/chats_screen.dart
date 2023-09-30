// import 'package:chat_app/screens/message_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubits/chat_cubit/chat_cubit.dart';
// import '../models/user_model.dart';
//
//
// class ChatScreen extends StatelessWidget {
//   static const String id = 'ChatPage';
//
//   List<UserModel> userList = [];
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var email=ModalRoute.of(context)!.settings.arguments as String;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chats'),
//         centerTitle: true,
//       ),
//       body: BlocBuilder<ChatCubit, ChatState>(
//         builder: (context, state) {
//           if (state is GetUserLoadingState) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is GetUserSuccessState) {
//             // BlocProvider.of<ChatCubit>(context).getMessage();
//             // BlocProvider.of<ChatCubit>(context).getUsers();
//
//             final List<UserModel> userList = state.users;
//             return ListView.builder(
//               itemCount: userList.length,
//               itemBuilder: (context, index) {
//                 final UserModel user = userList[index];
//
//                 return userList[index].email != email ? ListTile(
//                   leading: Image.network(user.image!),
//                   title: Text(user.userName!),
//                   onTap: () {
//                     // Navigate to the chat screen for the selected user
//                     Navigator.pushNamed(context, MessageScreen.id, arguments: user);
//                   },
//                 ) : Container();
//               },
//             );
//           } else if (state is GetUserErrorState) {
//             return Center(
//               child: Text('Error: ${state.error}'),
//             );
//           } else {
//             return Container(); // Return an empty container as a default case
//           }
//         },
//       ),
//     );
//   }
// }