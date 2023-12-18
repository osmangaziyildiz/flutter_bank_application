import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static final TextStyle menuTextStyle =
      GoogleFonts.aBeeZee(fontSize: 12, color: Colors.grey);

  static final TextStyle nameSurnameTextStyle =
      GoogleFonts.fjallaOne(fontSize: 25);

  static final TextStyle regionTextStyle =
      GoogleFonts.aBeeZee(fontSize: 15, color: Colors.grey);

  static final TextStyle appBarTextStyle = GoogleFonts.aBeeZee(fontSize: 25);

  static const Color iconColor = Colors.white;

  static const Color dashboardBackground = Color.fromARGB(255, 30, 30, 36);

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
