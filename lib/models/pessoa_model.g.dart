// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PessoaModelAdapter extends TypeAdapter<PessoaModel> {
  @override
  final int typeId = 0;

  @override
  PessoaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PessoaModel(
      fields[4] as int,
      fields[0] as int?,
      fields[1] as int?,
      fields[2] as double?,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PessoaModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._peso)
      ..writeByte(1)
      ..write(obj._altura)
      ..writeByte(2)
      ..write(obj._imc)
      ..writeByte(3)
      ..write(obj._classe)
      ..writeByte(4)
      ..write(obj._id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PessoaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
