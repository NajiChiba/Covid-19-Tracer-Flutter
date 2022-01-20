// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/contact.dart';
import 'models/qr_code.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4901301523609480838),
      name: 'Contact',
      lastPropertyId: const IdUid(3, 4781522523431345205),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1181985704822769179),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3632392953024569610),
            name: 'udid',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4781522523431345205),
            name: 'token',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 5171257371131833302),
      name: 'QrCode',
      lastPropertyId: const IdUid(5, 7477008174124355450),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8068092811114602381),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7850749581104630924),
            name: 'content',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5573753318861800854),
            name: 'type',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6463434311763302157),
            name: 'pcr',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7477008174124355450),
            name: 'date',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 5171257371131833302),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Contact: EntityDefinition<Contact>(
        model: _entities[0],
        toOneRelations: (Contact object) => [],
        toManyRelations: (Contact object) => {},
        getId: (Contact object) => object.id,
        setId: (Contact object, int id) {
          object.id = id;
        },
        objectToFB: (Contact object, fb.Builder fbb) {
          final udidOffset =
              object.udid == null ? null : fbb.writeString(object.udid!);
          final tokenOffset =
              object.token == null ? null : fbb.writeString(object.token!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, udidOffset);
          fbb.addOffset(2, tokenOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Contact(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              udid: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              token: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        }),
    QrCode: EntityDefinition<QrCode>(
        model: _entities[1],
        toOneRelations: (QrCode object) => [],
        toManyRelations: (QrCode object) => {},
        getId: (QrCode object) => object.id,
        setId: (QrCode object, int id) {
          object.id = id;
        },
        objectToFB: (QrCode object, fb.Builder fbb) {
          final contentOffset =
              object.content == null ? null : fbb.writeString(object.content!);
          final typeOffset =
              object.type == null ? null : fbb.writeString(object.type!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, contentOffset);
          fbb.addOffset(2, typeOffset);
          fbb.addBool(3, object.pcr);
          fbb.addInt64(4, object.date.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = QrCode(
              content: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              pcr: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              date: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0)),
              type: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Contact] entity fields to define ObjectBox queries.
class Contact_ {
  /// see [Contact.id]
  static final id = QueryIntegerProperty<Contact>(_entities[0].properties[0]);

  /// see [Contact.udid]
  static final udid = QueryStringProperty<Contact>(_entities[0].properties[1]);

  /// see [Contact.token]
  static final token = QueryStringProperty<Contact>(_entities[0].properties[2]);
}

/// [QrCode] entity fields to define ObjectBox queries.
class QrCode_ {
  /// see [QrCode.id]
  static final id = QueryIntegerProperty<QrCode>(_entities[1].properties[0]);

  /// see [QrCode.content]
  static final content =
      QueryStringProperty<QrCode>(_entities[1].properties[1]);

  /// see [QrCode.type]
  static final type = QueryStringProperty<QrCode>(_entities[1].properties[2]);

  /// see [QrCode.pcr]
  static final pcr = QueryBooleanProperty<QrCode>(_entities[1].properties[3]);

  /// see [QrCode.date]
  static final date = QueryIntegerProperty<QrCode>(_entities[1].properties[4]);
}
