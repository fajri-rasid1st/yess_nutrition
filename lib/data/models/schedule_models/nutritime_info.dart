class NutriTimeInfo {
  int? id;
  String title;
  DateTime alarmDateTime;
  bool? isPending;
  int gradientColorIndex;

  NutriTimeInfo(
      {  this.id,
      required this.title,
      required this.alarmDateTime,
       this.isPending,
      required this.gradientColorIndex});
  factory NutriTimeInfo.fromMap(Map<String, dynamic> json) => NutriTimeInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
     "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
  };
}
