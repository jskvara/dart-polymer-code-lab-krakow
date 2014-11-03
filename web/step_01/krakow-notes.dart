import 'package:polymer/polymer.dart';
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
  
  void createNote(Event event, Object noteText, Node target) {
    String noteText = (target as InputElement).value;
    if (noteText.isNotEmpty) {
      addNote(noteText);
    }
  }
  
  void addNote(String noteText) {  
    notes.add(new Note(noteText)); 
    $['note_add_form'].value = "";
    saveToLocalStorage();
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
