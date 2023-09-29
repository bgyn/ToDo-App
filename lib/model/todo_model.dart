class ToDo {
  int? id;
  String? description;
  String? date;
  bool? isComplete = false;
  ToDo({
    int? id,
    required this.description,
    bool? isComplete,
    required this.date,
  });

  int? getId() => id;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['description'] = description;
    if (isComplete == false) {
      map['isComplete'] = 'false';
    } else {
      map['isComplete'] = 'true';
    }
    map['date'] = date;
    return map;
  }

  ToDo.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    if (map['isComplete'] == 'true') {
      isComplete = true;
    } else {
      isComplete = false;
    }
    date = map['date'];
  }
}
