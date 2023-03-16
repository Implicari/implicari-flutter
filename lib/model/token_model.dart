class Token {
  int id;
  String email;
  String token;

  Token({
    required this.id,
    required this.email,
    required this.token,
  });

  factory Token.fromDatabaseJson(Map<String, dynamic> data) => Token(
        id: data['id'],
        email: data['email'],
        token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() =>
      {'id': id, 'email': email, 'token': token};
}
