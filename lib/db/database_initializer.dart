import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void initializeDatabase() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Initialize FFI loader if using desktop platforms
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
}
