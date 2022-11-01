// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class FileBoxParamenters {
  final double iconSize;
  final double iconSpacing;
  final double paddingHorizontal;
  final double radiusBox;
  final Brightness brightness;
  final double paddingVertical;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final Color? backgroundColor;
  final Color? colorTitle;
  final Color? colorCapacity;

  FileBoxParamenters({
    this.iconSize = 32,
    this.iconSpacing = 8,
    this.paddingHorizontal = 8,
    this.paddingVertical = 8,
    this.radiusBox = 7,
    this.brightness = Brightness.light,
    this.margin,
    this.height,
    this.backgroundColor,
    this.colorTitle,
    this.colorCapacity,
  });

  FileBoxParamenters copyWith({
    double? iconSize,
    double? iconSpacing,
    double? paddingHorizontal,
    double? radiusBox,
    Brightness? brightness,
    double? paddingVertical,
    double? height,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? colorTitle,
    Color? colorCapacity,
  }) {
    return FileBoxParamenters(
      iconSize: iconSize ?? this.iconSize,
      iconSpacing: iconSpacing ?? this.iconSpacing,
      paddingHorizontal: paddingHorizontal ?? this.paddingHorizontal,
      radiusBox: radiusBox ?? this.radiusBox,
      brightness: brightness ?? this.brightness,
      paddingVertical: paddingVertical ?? this.paddingVertical,
      margin: margin ?? this.margin,
      height: height ?? this.height,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      colorCapacity: colorCapacity ?? this.colorCapacity,
      colorTitle: colorTitle ?? this.colorTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iconSize': iconSize,
      'iconSpacing': iconSpacing,
      'paddingHorizontal': paddingHorizontal,
      'radiusBox': radiusBox,
      'paddingVertical': paddingVertical,
    };
  }

  factory FileBoxParamenters.fromMap(Map<String, dynamic> map) {
    return FileBoxParamenters(
      iconSize: map['iconSize'] as double,
      iconSpacing: map['iconSpacing'] as double,
      paddingHorizontal: map['paddingHorizontal'] as double,
      radiusBox: map['radiusBox'] as double,
      paddingVertical: map['paddingVertical'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileBoxParamenters.fromJson(String source) =>
      FileBoxParamenters.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FileCardModel(iconSize: $iconSize, iconSpacing: $iconSpacing, paddingHorizontal: $paddingHorizontal, radiusBox: $radiusBox, brightness: $brightness, paddingVertical: $paddingVertical)';
  }

  @override
  bool operator ==(covariant FileBoxParamenters other) {
    if (identical(this, other)) return true;

    return other.iconSize == iconSize &&
        other.iconSpacing == iconSpacing &&
        other.paddingHorizontal == paddingHorizontal &&
        other.radiusBox == radiusBox &&
        other.brightness == brightness &&
        other.paddingVertical == paddingVertical;
  }

  @override
  int get hashCode {
    return iconSize.hashCode ^
        iconSpacing.hashCode ^
        paddingHorizontal.hashCode ^
        radiusBox.hashCode ^
        brightness.hashCode ^
        paddingVertical.hashCode;
  }
}
