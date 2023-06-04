import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simplenote/models/note.dart';
import 'package:simplenote/pages/add_note_page.dart';
import 'package:simplenote/pages/homepages.dart';

class AppRoutes {
  static const home = "home";
  static const addNote = "add-note";
  static const editNote = "edit-note";

  static Page _homePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return const MaterialPage(
      child: HomePage(),
    );
  }

  static Page _addNotePageBuider(
    BuildContext context,
    GoRouterState state,
  ) {
    return const MaterialPage(
      child: AddNotePage(),
    );
  }

  static Page _editNotePageBuider(
    BuildContext context,
    GoRouterState state,
  ) {
    return MaterialPage(
      child: AddNotePage(
        note: state.extra as Note,
      ),
    );
  }

  static GoRouter goRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        name: home,
        path: "/",
        pageBuilder: _homePageBuilder,
        routes: [
          GoRoute(
            name: addNote,
            path: "add-note",
            pageBuilder: _addNotePageBuider,
          ),
          GoRoute(
            name: editNote,
            path: "edit-note",
            pageBuilder: _editNotePageBuider,
          ),
        ],
      ),
    ],
  );
}
