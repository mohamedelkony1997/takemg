class DataModel {
  final int id;
  final String title;
  final String description;
  final String imgLink;
  final String email;

  DataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgLink,
    required this.email,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imgLink: json['img_link'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'img_link': imgLink,
      'email': email,
    };
  }

  @override
  String toString() {
    return '{id: $id, title: $title, description: $description, imgLink: $imgLink, email: $email}';
  }
}
