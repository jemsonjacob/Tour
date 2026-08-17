// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_place_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedPlaceModelAdapter extends TypeAdapter<SavedPlaceModel> {
  @override
  final int typeId = 2;

  @override
  SavedPlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedPlaceModel(
      id: fields[0] as String,
      name: fields[1] as String,
      latitude: fields[2] as double,
      longitude: fields[3] as double,
      distance: fields[4] as int,
      categoryId: fields[5] as String,
      categoryName: fields[6] as String,
      categoryShortName: fields[7] as String,
      categoryIconUrl: fields[8] as String,
      address: fields[9] as String,
      locality: fields[10] as String,
      region: fields[11] as String,
      country: fields[12] as String,
      formattedAddress: fields[13] as String,
      phone: fields[14] as String?,
      website: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SavedPlaceModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.distance)
      ..writeByte(5)
      ..write(obj.categoryId)
      ..writeByte(6)
      ..write(obj.categoryName)
      ..writeByte(7)
      ..write(obj.categoryShortName)
      ..writeByte(8)
      ..write(obj.categoryIconUrl)
      ..writeByte(9)
      ..write(obj.address)
      ..writeByte(10)
      ..write(obj.locality)
      ..writeByte(11)
      ..write(obj.region)
      ..writeByte(12)
      ..write(obj.country)
      ..writeByte(13)
      ..write(obj.formattedAddress)
      ..writeByte(14)
      ..write(obj.phone)
      ..writeByte(15)
      ..write(obj.website);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
