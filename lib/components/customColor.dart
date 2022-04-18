import 'package:flutter/material.dart';

class P_Font {
  static String kronaOne = 'KronaOne-Regular';
}

class P_Image {
  static String login = 'asset/image/01.jpg';
  static String empty = 'asset/image/04.jpg';
}

class P_Settings {
  /// [title] Project Title
  static String get title => 'Order';

  // font color 
  static Color get fontColor => Color.fromARGB(255, 0, 0, 0);
  /// [color1] 
  static Color get color1 => Color.fromARGB(255, 199, 192, 207);

  /// [color2]  
  static Color get color2 => Color.fromARGB(255, 253, 255, 253);

  ////[color3]
  static Color get color3 => Colors.purple;

  ////[color4]
  static Color get color4 => Color.fromARGB(255, 206, 147, 216);
  
  // list tile color
  static Color get listColor => Color.fromARGB(255, 216, 196, 218);
  // table header color
  static Color get datatableColor => Color.fromARGB(255, 216, 196, 218);
  // home page date color
  static Color get dateviewColor => Color.fromARGB(255, 248, 246, 246);

  static Color get rowcolor => Color.fromARGB(255, 220, 178, 228);


}
