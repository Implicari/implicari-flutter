class Student {
  late int id;
  late String run;
  late String firstName;
  late String lastName;
  late int parentsAmount;

  Student({
    required this.id,
    required this.run,
    required this.firstName,
    required this.lastName,
    required this.parentsAmount,
  });

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    run = json['run'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    parentsAmount = json['parents'].length;
  }
}
