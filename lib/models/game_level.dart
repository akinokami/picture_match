class GameLevel {
  String? title;
  int? level;
  String? name;
  bool? playable;
  int? bestTime;
  int? limitTime;

  GameLevel(
      {this.title,
      this.level,
      this.name,
      this.playable,
      this.bestTime,
      this.limitTime});

  GameLevel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    level = json['level'];
    name = json['name'];
    playable = json['playable'];
    bestTime = json['bestTime'];
    limitTime = json['limitTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['level'] = level;
    data['name'] = name;
    data['playable'] = playable;
    data['bestTime'] = bestTime;
    data['limitTime'] = limitTime;
    return data;
  }
}
