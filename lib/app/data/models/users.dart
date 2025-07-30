class UsersModel {
  int? id;
  String? email;
  String? name;

  UsersModel({this.id, this.email, this.name});

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      UsersModel(id: json["id"], email: json["email"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "email": email, "name": name};
}
