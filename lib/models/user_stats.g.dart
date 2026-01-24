// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStatsAdapter extends TypeAdapter<UserStats> {
  @override
  final int typeId = 4;

  @override
  UserStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserStats(
      totalCoins: fields[0] as int,
      lastWaterCheckDate: fields[1] as DateTime?,
      tasksCompletedToday: fields[2] as int,
      lastResetDate: fields[3] as DateTime,
      hasUncompletedYesterdayTasks: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserStats obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.totalCoins)
      ..writeByte(1)
      ..write(obj.lastWaterCheckDate)
      ..writeByte(2)
      ..write(obj.tasksCompletedToday)
      ..writeByte(3)
      ..write(obj.lastResetDate)
      ..writeByte(4)
      ..write(obj.hasUncompletedYesterdayTasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
