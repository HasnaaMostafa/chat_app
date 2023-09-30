import 'package:chat_app/cubits/Auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../widgets/chat_item.dart';
import 'message_screen.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({super.key});

  static const String id = 'ChatDetailsPage';
  List<UserModel> userList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    // BlocProvider.of<ChatCubit>(context).getUsers(senderEmail: email);

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is GetUserLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xffE65100),
              ),
            ),
          );
        } else if (state is GetUserSuccessState) {
          final List<UserModel> userList = state.users;
          return Scaffold(
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color(0xffE65100),
                      Color(0xffEF6C00),
                      Color(0xffffA726),
                      Color(0xffE65100),
                    ],
                    begin: Alignment.topCenter,
                  )),
                ),
                Container(
                  width: 500,
                  height: 800,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(200),
                        topLeft: Radius.circular(200),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            final UserModel user = userList[index];
                            return userList[index].email != email
                                ? FutureBuilder<MessageModel?>(
                                    future: BlocProvider.of<ChatCubit>(context)
                                        .getLastReceivedMessage(
                                      senderEmail: email,
                                      recipientEmail: user.email!,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container();
                                      } else if (snapshot.hasData) {
                                        final lastMessage =
                                            snapshot.data!.message;
                                        return ChatItem(
                                          onTap: () {
                                            BlocProvider.of<ChatCubit>(context)
                                                .getMessage(
                                              recipientEmail: user.email!,
                                              senderEmail: email,
                                            );
                                            Navigator.pushNamed(
                                                context, MessageScreen.id,
                                                arguments: user);
                                          },
                                          sender: user.userName!,
                                          lastMessage:
                                              lastMessage, // Use the actual last message// Use the actual unread count
                                        );
                                      } else {
                                        return ChatItem(
                                          onTap: () {
                                            BlocProvider.of<ChatCubit>(context)
                                                .getMessage(
                                              recipientEmail: user.email!,
                                              senderEmail: email,
                                            );
                                            Navigator.pushNamed(
                                                context, MessageScreen.id,
                                                arguments: user);
                                          },
                                          sender: user.userName!,
                                          lastMessage:
                                              "", // Use the actual last message
                                          // Use the actual unread count
                                        );
                                      }
                                    },
                                  )
                                : Container();
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthCubit>(context).logoutUser();
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 55),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffE65100),
                          ),
                          child: const Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is GetUserErrorState) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        } else {
          return Container(
            color: Colors.white,
          ); // Return an empty container as a default case
        }
      },
    );
  }
}
