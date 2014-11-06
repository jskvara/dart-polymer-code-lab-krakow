import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_input.dart';
import 'dart:html';
import 'note.dart';

final String NOTES_LIST = "notesList";

/**
 * A Polymer krakow-notes element.
 */
@CustomTag('krakow-notes')
class KrakowNotes extends PolymerElement {

  @observable List notes = toObservable([]);

  KrakowNotes.created() : super.created() {
    notes.add(new Note('ttt'));
    notes.add(new Note('aaa'));
  }
  
  void createNote(Event event, Object noteText, PaperInput target) {
    String noteText = target.value;
    if (noteText.isNotEmpty) {
      addNote(noteText);
      target.inputValue = '';
      target.commit();
    }
  }
  
  void addNote(String noteText) {  
    notes.add(new Note(noteText)); 
    saveToLocalStorage();
  }
  
  void deleteNote(Event event, var note) {
    int index = note['index'];
    notes.removeAt(index);
  }
  
  void deleteAll(Event event) {
    notes.clear();
  }

  void loadFromLoacalStorage() {
    if (window.localStorage[NOTES_LIST] != null) {
      notes = Note.fromJson(window.localStorage[NOTES_LIST]);
    }
  }

  void saveToLocalStorage() {
    window.localStorage[NOTES_LIST] = Note.toJson(notes);
  }
}
