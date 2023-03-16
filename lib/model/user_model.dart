class User {
  late int id;
  late String email;

  User({
    required this.id,
    required this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
  }
}
