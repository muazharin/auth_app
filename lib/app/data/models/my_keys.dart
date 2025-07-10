class MyKeysModel {
  int? id;
  String? name;
  String? key;
  bool? active;
  Creator? creator;

  MyKeysModel({this.id, this.name, this.key, this.active, this.creator});

  factory MyKeysModel.fromJson(Map<String, dynamic> json) => MyKeysModel(
    id: json["id"],
    name: json["name"],
    key: json["key"],
    active: json["active"],
    creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "key": key,
    "active": active,
    "creator": creator?.toJson(),
  };
}

class Creator {
  int? id;
  String? email;
  String? name;

  Creator({this.id, this.email, this.name});

  factory Creator.fromJson(Map<String, dynamic> json) =>
      Creator(id: json["id"], email: json["email"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "email": email, "name": name};
}
