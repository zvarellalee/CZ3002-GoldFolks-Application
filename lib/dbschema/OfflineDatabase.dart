import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class OfflineDatabase {
  // singleton instance
  static final OfflineDatabase _instance = OfflineDatabase._();

  // singleton getter
  static OfflineDatabase get instance => _instance;

  OfflineDatabase._();

  Completer<Database> _dbCompleter;

  // Database object accessor
  Future<Database> get database async {
    if (_dbCompleter == null) {
      _dbCompleter = Completer();
      _openDatabase();
    }
    return _dbCompleter.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'ReminderDB.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbCompleter.complete(database);
  }
}