library generated_emblems;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:monarchium/backend/schema/serializers.dart';

part 'generated_emblems.g.dart';

abstract class GeneratedEmblems
    implements Built<GeneratedEmblems, GeneratedEmblemsBuilder> {
  GeneratedEmblems._();

  factory GeneratedEmblems([updates(GeneratedEmblemsBuilder b)]) =
      _$GeneratedEmblems;

  @BuiltValueField(wireName: 'background_color')
  String? get backgroundColor;
  @BuiltValueField(wireName: 'emblem')
  String? get emblem;
  @BuiltValueField(wireName: 'filled')
  bool? get filled;

  String toJson() {
    return json
        .encode(serializers.serializeWith(GeneratedEmblems.serializer, this));
  }

  static GeneratedEmblems? fromJson(String jsonString) {
    return serializers.deserializeWith(
        GeneratedEmblems.serializer, json.decode(jsonString));
  }

  static Serializer<GeneratedEmblems> get serializer =>
      _$generatedEmblemsSerializer;
}
