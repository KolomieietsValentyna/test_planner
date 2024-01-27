class TaskModel {
  final String id;
  final String title;
  final String description;
  final String category;
  bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.isDone = false,
  });

  void changeStatus() {
    isDone = !isDone;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'isDone': isDone,
      };

  TaskModel.fromJson(Map<String, dynamic> json)
      : 
      id = json['id'],
      title = json['title'],
        description = json['description'],
        category = json['category'],
        isDone = json['isDone'];
}
