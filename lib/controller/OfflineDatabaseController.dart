import 'package:goldfolks/dbschema/OfflineDatabase.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:sembast/sembast.dart';

/// DaAO class for offline ReminderDB
class OfflineDatabaseController {
  static const String folderName = "Reminders";
  final _folder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await OfflineDatabase.instance.database;

  // CRUD Operations
  Future createReminder(Reminder reminder) async {
    await _folder.add(await _db, reminder.toJson());
  }

  Future<List<Reminder>> getReminders() async {
    final snapshot = await _folder.find(await _db);
    return snapshot.map((a) => Reminder.fromJson(a.value));
  }

  Future updateReminder(Reminder reminder) async {
    final finder = Finder(filter: Filter.byKey(reminder.hashCode)); // TODO: instead of hashcode, use id?
    await _folder.update(await _db, reminder.toJson(), finder: finder);
  }

  Future deleteReminder(Reminder reminder) async {
    final finder = Finder(filter: Filter.byKey(reminder.hashCode)); // TODO: instead of hashcode, use id?
    await _folder.delete(await _db, finder: finder);
  }


}