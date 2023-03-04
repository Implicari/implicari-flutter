class Course {

  late int id;
  late String name;

  Course({
      required this.id,
      required this.name,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
