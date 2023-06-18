import '../../services/service.dart';

class UserModel {
  String? email;
  String? name;
  String? phone;
  String? username;
  String? gender;
  String? bio;
  String? profile;
  String? password;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.email,
    this.phone,
    this.name,
    this.username,
    this.gender,
    this.bio,
    this.profile,
    this.password,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  UserModel copyWith({
    String? phone,
    String? email,
    String? name,
    String? username,
    String? gender,
    String? bio,
    String? profile,
    String? password,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserModel(
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        username: username ?? this.username,
        gender: gender ?? this.gender,
        bio: bio ?? this.bio,
        profile: profile ?? this.profile,
        password: password ?? this.password,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        username: json["username"],
        gender: json["gender"],
        bio: json["bio"],
        profile: json.containsKey('profile')
            ? '${AppService.url}/${json["profile"]}'
            : null,
        password: json["password"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "phone": phone,
        "username": username,
        "gender": gender,
        "bio": bio,
        "password": password,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
