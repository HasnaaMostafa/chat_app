import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import '../widgets/chat_bubble.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  static String id = "MessageScreen";

  final controller = ScrollController();

  var messageController = TextEditingController();

  // List<MessageModel> messagesList = [];


  @override
  Widget build(BuildContext context) {
    var user = ModalRoute
        .of(context)!
        .settings
        .arguments as UserModel;

    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context,state){
        // if (state is ChatSuccessState){
        //   messagesList=state.messages;
        // }
      },
      builder: (context, state) {
        BlocProvider.of<ChatCubit>(context).getUsers();
        var messagesList = BlocProvider
            .of<ChatCubit>(context)
            .messagesList;

        // BlocProvider.of<ChatCubit>(context).getMessage();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffE65100),
            foregroundColor: Colors.white,
            title: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Center(child: Text(user.userName!)),
              ],
            ),
            titleSpacing: 80,
          ),
          body: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              children: [
                Expanded(
                    child:ListView.builder(
                            reverse: true,
                            controller: controller,
                            itemCount: messagesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return messagesList[index].senderEmail ==
                                  LoginScreen.email ?
                              ChatBubble(message: messagesList[index],) :
                              ChatBubbleForFriend(message: messagesList[index]);
                            })),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: const BorderSide(
                              color: Color(0xffE65100),
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: const BorderSide(
                              color: Color(0xffE65100),
                            )
                        ),
                        hintText: "Write Message",
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Color(0xffE65100),
                          ),
                          onPressed: () {
                            BlocProvider.of<ChatCubit>(context).sendMessage(
                              senderEmail: LoginScreen.email!,
                              recipientEmail: user.email!,
                              message: messageController.text,);
                            messageController.clear();
                            controller.animateTo(
                                0,
                                duration: const Duration(microseconds: 1),
                                curve: Curves.fastOutSlowIn);
                          },

                        )
                    ),
                    onSubmitted: (data) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                          senderEmail: LoginScreen.email!,
                          recipientEmail: user.email!,
                          message: data);
                      messageController.clear();
                      controller.animateTo(
                          0,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    },
                  ),
                )

              ],
            ),

          ),
        );
      },
    );
  }
}




