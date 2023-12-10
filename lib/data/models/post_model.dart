class PostModel {
  late int id;
  late String title;
  late String descr;

  PostModel({required this.id, required this.title, required this.descr});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? 'no_title';
    descr = json['body'] ?? 'no_body';
  }
}
