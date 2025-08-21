class UserModel
{
  late String name;
  late String email;
  String? image;
  late DateTime? createdAt;


  UserModel({required this.name, required this.email, this.image, this.createdAt})
  {
    if (createdAt == null) {
      this.createdAt = DateTime.now();
    }
  }

  UserModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    image = json['image'];
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now();
  }

  Map<String, dynamic> toJson()
  {
    return {
      'name': name,
      'email': email,
      'image': image
      , 'createdAt': createdAt?.toIso8601String(),
    };
  }


}