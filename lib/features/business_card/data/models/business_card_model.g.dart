// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessCardModelAdapter extends TypeAdapter<BusinessCardModel> {
  @override
  final int typeId = 0;

  @override
  BusinessCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusinessCardModel(
      modelId: fields[0] as String?,
      modelName: fields[1] as String,
      modelTitle: fields[2] as String?,
      modelCompany: fields[3] as String?,
      modelEmail: fields[4] as String?,
      modelPhone: fields[5] as String?,
      modelWebsite: fields[6] as String?,
      modelAddress: fields[7] as String?,
      modelCreatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BusinessCardModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.modelId)
      ..writeByte(1)
      ..write(obj.modelName)
      ..writeByte(2)
      ..write(obj.modelTitle)
      ..writeByte(3)
      ..write(obj.modelCompany)
      ..writeByte(4)
      ..write(obj.modelEmail)
      ..writeByte(5)
      ..write(obj.modelPhone)
      ..writeByte(6)
      ..write(obj.modelWebsite)
      ..writeByte(7)
      ..write(obj.modelAddress)
      ..writeByte(8)
      ..write(obj.modelCreatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
