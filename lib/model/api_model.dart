class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});

  Map <String, dynamic> toDatabaseJson() => {
    "email": email,
    "password": password
  };
}

class Token{
  String token;

  Token({required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token']
    );
  }
}

