import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplenote/Utile/app_route.dart';
import 'package:simplenote/db/database_services.dart';
import 'package:simplenote/extensions/format.dart';
import 'package:simplenote/models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Databaseservice dbservice = Databaseservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("Simple Note App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).goNamed(
            AppRoutes.addNote,
          );
        },
        child: const Icon(
          Icons.add_chart_rounded,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(Databaseservice.boxName).listenable(),
        builder: (context, box, child) {
          if (box.isEmpty) {
            return const Center(
              child: Text("Tidak Ada catatan"),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(box.getAt(index).key.toString()),
                  child: NoteCard(note: box.getAt(index)),
                  onDismissed: (_) async {
                    await dbservice.deleteNotes(box.getAt(index)).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${box.getAt(index).title} Data telah dihapus"),
                      ));
                    });
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
              itemCount: box.length,
            );
          }
        },
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromARGB(255, 212, 224, 45)),
      child: ListTile(
        onTap: () {
          GoRouter.of(context).pushNamed(
            AppRoutes.editNote,
            extra: note,
          );
        },
        title: Text(
          note.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          note.description,
          maxLines: 1,
        ),
        trailing: Text(note.creation.formatDate()),
      ),
    );
  }
}
