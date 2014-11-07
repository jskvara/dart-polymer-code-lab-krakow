import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_input.dart';
import 'dart:html';
import 'note.dart';

/**
 * A Polymer krakow-notes element.
 */
@CustomTag('krakow-notes')
class KrakowNotes extends PolymerElement {

  @observable List notes = toObservable([]);

  KrakowNotes.created() : super.created() {
  }
  
  void createNote(Event event, Object noteText, PaperInput target) {
    String noteText = target.value;
    if (noteText.isNotEmpty) {
      notes.add(new Note(noteText));
      target.inputValue = '';
      target.commit();
    }
  }
}
