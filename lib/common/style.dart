import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFF6B38FB);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.merriweather(
    fontSize: 92,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: Colors.black,
  ),
  displayMedium: GoogleFonts.merriweather(
    fontSize: 57,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: Colors.black,
  ),
  displaySmall: GoogleFonts.merriweather(
    fontSize: 46,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  headlineMedium: GoogleFonts.merriweather(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.black,
  ),
  headlineSmall: GoogleFonts.merriweather(
    fontSize: 23,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  titleLarge: GoogleFonts.merriweather(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: Colors.black,
  ),
  titleMedium: GoogleFonts.merriweather(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: Colors.black,
  ),
  titleSmall: GoogleFonts.merriweather(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: Colors.black,
  ),
  bodyLarge: GoogleFonts.libreFranklin(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: Colors.black,
  ),
  bodyMedium: GoogleFonts.libreFranklin(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.black,
  ),
  labelLarge: GoogleFonts.libreFranklin(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: Colors.black,
  ),
  bodySmall: GoogleFonts.libreFranklin(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: Colors.black,
  ),
  labelSmall: GoogleFonts.libreFranklin(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    color: Colors.black,
  ),
);
