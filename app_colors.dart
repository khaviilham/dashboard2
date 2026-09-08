import 'package:flutter/material.dart';

/// Palet warna & style bersama supaya semua halaman
/// (Landing, Riwayat, Profile, Utama) punya tampilan yang konsisten.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF6B35); // oranye khas app makanan
  static const Color primaryDark = Color(0xFFE85A2A);
  static const Color primaryLight = Color(0xFFFFE8DD);

  static const Color background = Color(0xFFF8F9FB);
  static const Color card = Colors.white;

  static const Color textDark = Color(0xFF1F2937);
  static const Color textGrey = Color(0xFF6B7280);

  static const Color success = Color(0xFF16A34A);
  static const Color pending = Color(0xFFF59E0B);
  static const Color cancelled = Color(0xFFDC2626);

  // Palet warna lembut untuk kartu kantin / avatar kategori
  static const List<Color> soft = [
    Color(0xFFDCEBFF), // biru
    Color(0xFFDFF6EC), // teal
    Color(0xFFFFF3D6), // amber
    Color(0xFFFFE1E1), // merah
    Color(0xFFEEE1FF), // ungu
    Color(0xFFE1F7E1), // hijau
  ];

  static Color softAt(int index) => soft[index % soft.length];

  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 12,
    offset: const Offset(0, 4),
  );
}