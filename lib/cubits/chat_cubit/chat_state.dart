part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccessState extends ChatState {
  List<MessageModel> messages;
  int? lastMessageNumber;
  ChatSuccessState({required this.messages, this.lastMessageNumber});
}

class ChatSendSuccessState extends ChatState {}

class ChatErrorState extends ChatState {
  String error;
  ChatErrorState(this.error);
}

class ChatLoadingState extends ChatState {}

class GetUserSuccessState extends ChatState {
  List<UserModel> users;
  GetUserSuccessState({required this.users});
}

class GetUserErrorState extends ChatState {
  String error;
  GetUserErrorState(this.error);
}

class GetUserLoadingState extends ChatState {}

class LastReceivedMessageLoadedState extends ChatState {
  MessageModel? message;
  int? countMessages;
  LastReceivedMessageLoadedState(this.message, this.countMessages);
}

class LastReceivedMessageErrorState extends ChatState {
  String error;
  LastReceivedMessageErrorState(this.error);
}

class LastReceivedMessageSuccessState extends ChatState {
  MessageModel messages;
  LastReceivedMessageSuccessState(this.messages);
}

class LastReceiveMessagesEmptyState extends ChatState {}

class GetLastMessageNumberLoadingState extends ChatState {}

class GetLastMessageNumberSuccessState extends ChatState {
  int messages;
  GetLastMessageNumberSuccessState(this.messages);
}

class GetLastMessageNumberErrorState extends ChatState {
  String error;
  GetLastMessageNumberErrorState(this.error);
}

class GetLastMessageNumberEmptyState extends ChatState {}
