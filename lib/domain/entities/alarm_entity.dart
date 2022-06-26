import 'package:equatable/equatable.dart';

class AlarmEntity extends Equatable {
  final int? id;
  final String uid;
  final String title;
  final DateTime scheduledAt;
  final bool isPending;
  final int gradientColorIndex;

  const AlarmEntity({
    this.id,
    required this.uid,
    required this.title,
    required this.scheduledAt,
    required this.isPending,
    required this.gradientColorIndex,
  });

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
