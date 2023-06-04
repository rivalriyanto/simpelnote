import 'package:hive/hive.dart';
import 'package:simplenote/models/note.dart';

class Databaseservice {
  static const boxName = 'notes';

  Future<void> addNote(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.add(note);
  }

  Future<void> editnote(int key, Note note) async {
    final box = await Hive.openBox(boxName);
    await box.put(note.key, note);
  }

  Future<List<Note>> getNotes(Note note) async {
    final box = await Hive.openBox(boxName);
    return box.get(note.key);
  }

  Future<void> deleteNotes(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.delete(note.key);
  }
}
