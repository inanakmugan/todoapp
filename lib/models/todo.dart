final String tableTodos = 'todos';

class Todofields {
  static final List<String> values = [id, title, isChanged, date];

  static final String id = "_id";
  static final String title = "title";
  static final String isChanged = 'isChanged';
  static final String date = 'date';
}

class Todo {
  final int? id;
  String title;
  bool isChanged;
  DateTime date;

  Todo(
      {this.id,
      required this.title,
      required this.isChanged,
      required this.date});

  Map<String, Object?> toJson() => {
        Todofields.id: id,
        Todofields.title: title,
        Todofields.isChanged: isChanged ? 1 : 0,
        Todofields.date: date.toIso8601String(),
      };

  static Todo fromJson(Map<String, Object?> json) => Todo(
        id: json[Todofields.id] as int?,
        title: json[Todofields.title] as String,
        isChanged: json[Todofields.isChanged] == 1,
        date: DateTime.parse(json[Todofields.date] as String),
      );

  Todo copy({
    int? id,
    String? title,
    bool? isChanged,
    DateTime? date,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        isChanged: isChanged ?? this.isChanged,
        date: date ?? this.date,
      );
}
