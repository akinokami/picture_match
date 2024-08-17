class GameLevel {
  String? title;
  int? level;
  String? name;
  bool? playable;
  int? bestTime;

  GameLevel({this.title, this.level, this.name, this.playable, this.bestTime});

  GameLevel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    level = json['level'];
    name = json['name'];
    playable = json['playable'];
    bestTime = json['bestTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['level'] = level;
    data['name'] = name;
    data['playable'] = playable;
    data['bestTime'] = bestTime;
    return data;
  }
}
