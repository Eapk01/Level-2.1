import 'dart:io';

class note {
  String? NoteName, Note; //Works as long as the note is less than 2,147,483,647 characters...
  note({this.NoteName, this.Note});
}

class NoteManager {
  int count = 0;
  List<note> notes = [];

  void addNote(note newNote) {
    notes.add(newNote);
    count = count + 1;
  }

  void viewNotes() {
    int b = 0;
    for (note a in notes) {
      print('${++b} - ${a.NoteName ?? "Unnamed Note"}');
    }
  }

  void printNoteAt(int index) {
    if (index >= 0 && index < notes.length) {
      print('Title: ${notes[index].NoteName}');
      print('Content: ${notes[index].Note}');
    }
  }

  void removeNoteAt(int index) {
    if (index >= 0 && index < notes.length) {
      notes.removeAt(index);
      count = notes.length;
    }
  }

  void updateNoteAt(int index, String? newNoteName, String? newNoteContent) {
    if (index >= 0 && index < notes.length) {
      notes[index].NoteName = newNoteName;
      notes[index].Note = newNoteContent;
    }
  }
}

class NoteApp {
  void run() {
    NoteManager noteManager = NoteManager();

    while (true) {
      try {
        print("Choose an option:");
        print("1. Add a new note");
        print("2. View notes");
        print("3. View a note");
        print("4. Update a note");
        print("5. Remove a note");
        print("6. Exit");

        String? choice = stdin.readLineSync();

        switch (choice) {
          case '1':
            print("Enter note name:");
            String? noteName = stdin.readLineSync();
            print("Enter note content:");
            String? noteContent = stdin.readLineSync();

            noteManager.addNote(note(NoteName: noteName, Note: noteContent));
            print("Note added successfully.");
            break;

          case '2':
            print("Notes:");
            noteManager.viewNotes();
            break;

          case '3':
            print("Enter the index of the note to read:");
            String? indexStr = stdin.readLineSync();
            int? index = int.tryParse(indexStr ?? '');
            if (index != null && index >= 0 && index < noteManager.notes.length) {
              noteManager.printNoteAt(index);
            } else {
              print("Invalid index.");
            }
            break;

          case '4':
            print("Enter the index of the note to update:");
            String? indexStr = stdin.readLineSync();
            int? index = int.tryParse(indexStr ?? '');

            if (index != null && index >= 0 && index < noteManager.notes.length) {
              print("Enter new note name:");
              String? newNoteName = stdin.readLineSync();
              print("Enter new note content:");
              String? newNoteContent = stdin.readLineSync();

              noteManager.updateNoteAt(index, newNoteName, newNoteContent);
              print("Note updated successfully.");
            } else {
              print("Invalid index.");
            }
            break;

          case '5':
            print("Enter the index of the note to remove:");
            String? indexStr = stdin.readLineSync();
            int? index = int.tryParse(indexStr ?? '');

            if (index != null && index >= 0 && index < noteManager.notes.length) {
              noteManager.removeNoteAt(index);
              print("Note removed successfully.");
            } else {
              print("Invalid index.");
            }
            break;

          case '6':
            return;

          default:
            print("Invalid option. Please try again.");
            break;
        }
      } catch (e) {
        print("An error occurred: $e");
      }
    }
  }
}

