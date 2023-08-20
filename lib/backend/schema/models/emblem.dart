import 'dart:convert';

import 'package:monarchium/backend/backend.dart';

class Emblem {
  final Color? backgroundColor;
  final String? url;

  Emblem({
    this.backgroundColor,
    this.url,
  });

  Emblem copyWith({
    Color? backgroundColor,
    String? url,
  }) {
    return Emblem(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (backgroundColor != null) {
      result.addAll({'backgroundColor': backgroundColor!.value});
    }
    if (url != null) {
      result.addAll({'url': url});
    }

    return result;
  }

  factory Emblem.fromMap(Map<String, dynamic> map) {
    return Emblem(
      backgroundColor:
          map['backgroundColor'] != null ? Color(map['backgroundColor']) : null,
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Emblem.fromEmblemsRecord(EmblemsRecord? emblemsRecord) {
    Color? hexColor;

    if (emblemsRecord == null) {
      return Emblem();
    }

    if (emblemsRecord.backgroundColor != null) {
      hexColor = emblemsRecord.backgroundColor!;
    } else if (emblemsRecord.suggestedColors != null &&
        emblemsRecord.suggestedColors!.isNotEmpty) {
      hexColor = emblemsRecord.suggestedColors![1];
    }

    return Emblem(
      backgroundColor: hexColor,
      url: emblemsRecord.emblem,
    );
  }

  factory Emblem.fromJson(String source) => Emblem.fromMap(json.decode(source));

  @override
  String toString() => 'Emblem(backgroundColor: $backgroundColor, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Emblem &&
        other.backgroundColor == backgroundColor &&
        other.url == url;
  }

  @override
  int get hashCode => backgroundColor.hashCode ^ url.hashCode;
}
