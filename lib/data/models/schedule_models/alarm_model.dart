import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/alarm_entity.dart';

const alarmScheduleTable = 'alarm_schedule_table';

class AlarmModel extends Equatable {
  final int? id;
  final String uid;
  final String title;
  final DateTime scheduledAt;
  final bool isPending;
  final int gradientColorIndex;

  const AlarmModel({
    this.id,
    required this.uid,
    required this.title,
    required this.scheduledAt,
    required this.isPending,
    required this.gradientColorIndex,
  });

  factory AlarmModel.fromEntity(AlarmEntity alarm) {
    return AlarmModel(
      id: alarm.id,
      uid: alarm.uid,
      title: alarm.title,
      scheduledAt: alarm.scheduledAt,
      isPending: alarm.isPending,
      gradientColorIndex: alarm.gradientColorIndex,
    );
  }

  factory AlarmModel.fromMap(Map<String, dynamic> alarm) {
    return AlarmModel(
      id: alarm['id'] as int,
      uid: alarm['uid'] as String,
      title: alarm['title'] as String,
      scheduledAt: DateTime.parse(alarm['scheduledAt'] as String),
      isPending: (alarm['isPending'] as int) == 1 ? true : false,
      gradientColorIndex: alarm['gradientColorIndex'] as int,
    );
  }

  AlarmEntity toEntity() {
    return AlarmEntity(
      id: id,
      uid: uid,
      title: title,
      scheduledAt: scheduledAt,
      isPending: isPending,
      gradientColorIndex: gradientColorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'scheduledAt': scheduledAt.toIso8601String(),
      'isPending': isPending ? 1 : 0,
      'gradientColorIndex': gradientColorIndex,
    };
  }

  @override
  List<Object?> get props => [
        id,
        uid,
        title,
        scheduledAt,
        isPending,
        gradientColorIndex,
      ];
}
