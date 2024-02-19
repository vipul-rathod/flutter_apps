// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataModelAdapter extends TypeAdapter<DataModel> {
  @override
  final int typeId = 0;

  @override
  DataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataModel(
      name: fields[0] as String?,
      dob: fields[1] as String?,
      phone: fields[2] as String?,
      expLevel: fields[3] as String?,
      gender: fields[4] as String?,
      confirmation: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, DataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dob)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.expLevel)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.confirmation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
