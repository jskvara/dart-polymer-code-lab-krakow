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
    loadFromLoacalStorage();
  }
  
  void createNote(Event event, Object noteText, PaperInput target) {
    String noteText = target.value;
    if (noteText.isNotEmpty) {
      notes.add(new Note(noteText)); 
      saveToLocalStorage();
      target.inputValue = '';
      target.commit();
    }
  }

  void deleteNote(Event event, var note) {
    int index = note['index'];
    notes.removeAt(index);
    saveToLocalStorage();
  }

  void deleteAll(Event event) {
    notes.clear();
    saveToLocalStorage();
  }

  void loadFromLoacalStorage() {
    if (window.localStorage[NOTES_LIST] != null) {
      notes = toObservable(Note.fromJson(window.localStorage[NOTES_LIST]));
    }
  }

  void saveToLocalStorage() {
    window.localStorage[NOTES_LIST] = Note.toJson(notes);
  }
}
