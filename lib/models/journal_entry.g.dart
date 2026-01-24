// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalEntryAdapter extends TypeAdapter<JournalEntry> {
  @override
  final int typeId = 2;

  @override
  JournalEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalEntry(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      content: fields[2] as String,
      mood: fields[3] as JournalMood,
    );
  }

  @override
  void write(BinaryWriter writer, JournalEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.mood);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class JournalMoodAdapter extends TypeAdapter<JournalMood> {
  @override
  final int typeId = 3;

  @override
  JournalMood read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return JournalMood.happy;
      case 1:
        return JournalMood.neutral;
      case 2:
        return JournalMood.sad;
      default:
        return JournalMood.happy;
    }
  }

  @override
  void write(BinaryWriter writer, JournalMood obj) {
    switch (obj) {
      case JournalMood.happy:
        writer.writeByte(0);
        break;
      case JournalMood.neutral:
        writer.writeByte(1);
        break;
      case JournalMood.sad:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalMoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
