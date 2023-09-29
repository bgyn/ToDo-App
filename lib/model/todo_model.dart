class ToDo {
  int? id;
  String? description;
  String? date;
  bool? isComplete = false;
  ToDo({
    required this.description,
    bool? isComplete,
    required this.date,
    int? id,
  });

  ToDo copy(bool isComplete) => ToDo(
      id: id, description: description, isComplete: isComplete, date: date);

  ToDo update({String? description, String? date}) => ToDo(
        id: id,
        description: description ?? this.description,
        isComplete: isComplete,
        date: date ?? this.date,
      );

  @override
  bool operator ==(covariant ToDo other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['description'] = description;
    if (isComplete == null) {
      map['isComplete'] = 'false';
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

//stateNotifier
