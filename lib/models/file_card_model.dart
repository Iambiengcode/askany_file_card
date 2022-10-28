// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/material.dart';

// class FileCardModel {
//   final double iconSize;
//   final double iconSpacing;
//   final double paddingHorizontal;
//   final double radiusBox;
//   final Brightness brightness;
//   final double paddingVertical;
//   FileCardModel({
//     required this.iconSize,
//     required this.iconSpacing,
//     required this.paddingHorizontal,
//     required this.radiusBox,
//     required this.brightness,
//     required this.paddingVertical,
//   });

//   FileCardModel copyWith({
//     double? iconSize,
//     double? iconSpacing,
//     double? paddingHorizontal,
//     double? radiusBox,
//     Brightness? brightness,
//     double? paddingVertical,
//   }) {
//     return FileCardModel(
//       iconSize: iconSize ?? this.iconSize,
//       iconSpacing: iconSpacing ?? this.iconSpacing,
//       paddingHorizontal: paddingHorizontal ?? this.paddingHorizontal,
//       radiusBox: radiusBox ?? this.radiusBox,
//       brightness: brightness ?? this.brightness,
//       paddingVertical: paddingVertical ?? this.paddingVertical,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'iconSize': iconSize,
//       'iconSpacing': iconSpacing,
//       'paddingHorizontal': paddingHorizontal,
//       'radiusBox': radiusBox,
//       'brightness': brightness.toMap(),
//       'paddingVertical': paddingVertical,
//     };
//   }

//   factory FileCardModel.fromMap(Map<String, dynamic> map) {
//     return FileCardModel(
//       iconSize: map['iconSize'] as double,
//       iconSpacing: map['iconSpacing'] as double,
//       paddingHorizontal: map['paddingHorizontal'] as double,
//       radiusBox: map['radiusBox'] as double,
//       brightness: Brightness.fromMap(map['brightness'] as Map<String, dynamic>),
//       paddingVertical: map['paddingVertical'] as double,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory FileCardModel.fromJson(String source) =>
//       FileCardModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'FileCardModel(iconSize: $iconSize, iconSpacing: $iconSpacing, paddingHorizontal: $paddingHorizontal, radiusBox: $radiusBox, brightness: $brightness, paddingVertical: $paddingVertical)';
//   }

//   @override
//   bool operator ==(covariant FileCardModel other) {
//     if (identical(this, other)) return true;

//     return other.iconSize == iconSize &&
//         other.iconSpacing == iconSpacing &&
//         other.paddingHorizontal == paddingHorizontal &&
//         other.radiusBox == radiusBox &&
//         other.brightness == brightness &&
//         other.paddingVertical == paddingVertical;
//   }

//   @override
//   int get hashCode {
//     return iconSize.hashCode ^
//         iconSpacing.hashCode ^
//         paddingHorizontal.hashCode ^
//         radiusBox.hashCode ^
//         brightness.hashCode ^
//         paddingVertical.hashCode;
//   }
// }
