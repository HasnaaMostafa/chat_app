class MessageModel {
  final String message;
  final String senderEmail;
  final String recipientEmail;

  MessageModel(
      {required this.message,
      required this.senderEmail,
      required this.recipientEmail});

  factory MessageModel.fromjson(json) {
    return MessageModel(
        message: json["message"],
        senderEmail: json["senderEmail"],
        recipientEmail: json["recipientEmail"]);
  }
}
