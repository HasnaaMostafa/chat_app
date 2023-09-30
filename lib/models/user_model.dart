class UserModel {
  String? userName;
  String? email;
  String? phone;
  String? uId;
  String? image;

  UserModel({
    this.userName,
    this.uId,
    this.email,
    this.phone,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    userName = json["userName"];
    phone = json["phone"];
    uId = json["uId"];
    image = json["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "email": email,
      "phone": phone,
      "uId": uId,
      "image": image,
    };
  }
}
