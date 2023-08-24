import 'package:flutter/material.dart';

/* ------------------------------ ColorStrings ------------------------------ */
/// [ColorStrings] provides useful [String] to [Color] and [Color] to [String]
/// transformations using the ARGB format.
extension ColorStrings on Color {
  String get toStringARGB {
    return "$alpha,$red,$green,$blue";
  }

  static Color fromStringARGB(String argbaString) {
    /// Does the string have commas & is it of length 4?
    assert(argbaString.contains(',') && argbaString.split(',').length == 4);

    /// Split the list
    List<String> argbaList = argbaString.split(',');

    /// Return the correct color
    return Color.fromARGB(int.parse(argbaList[0]), int.parse(argbaList[1]),
        int.parse(argbaList[2]), int.parse(argbaList[3]));
  }
}
