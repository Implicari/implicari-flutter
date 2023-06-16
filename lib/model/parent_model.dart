class Parent {
  late int id;
  late String run;
  late String firstName;
  late String lastName;

  Parent({
    required this.id,
    required this.run,
    required this.firstName,
    required this.lastName,
  });

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    run = json['run'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }
}
