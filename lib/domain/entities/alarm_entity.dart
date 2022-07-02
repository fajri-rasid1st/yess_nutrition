import 'package:equatable/equatable.dart';

class AlarmEntity extends Equatable {
  final int? id;
  final String uid;
  final String title;
  final DateTime scheduledAt;
  final bool isActive;
  final int gradientColorIndex;

  const AlarmEntity({
    this.id,
    required this.uid,
    required this.title,
    required this.scheduledAt,
    required this.isActive,
    required this.gradientColorIndex,
  });

  AlarmEntity copyWith({
    int? id,
    String? uid,
    String? title,
    DateTime? scheduledAt,
    bool? isActive,
    int? gradientColorIndex,
  }) {
    return AlarmEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      isActive: isActive ?? this.isActive,
      gradientColorIndex: gradientColorIndex ?? this.gradientColorIndex,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uid,
        title,
        scheduledAt,
        isActive,
        gradientColorIndex,
      ];
}
