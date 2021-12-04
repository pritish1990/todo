class UserModel {
  String? uid;
  String? imageUrl;
  String? userEmail;
  String? username;

  UserModel({this.uid, this.imageUrl, this.userEmail, this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    imageUrl = json['imageUrl'];
    userEmail = json['userEmail'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['imageUrl'] = this.imageUrl;
    data['userEmail'] = this.userEmail;
    data['username'] = this.username;
    return data;
  }
}
