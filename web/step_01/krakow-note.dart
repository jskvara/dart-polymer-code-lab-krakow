import 'package:polymer/polymer.dart';
import 'dart:html';
import 'note.dart';

/**
 * A Polymer krakow-note element.
 */
@CustomTag('krakow-note')
class KrakowNote extends PolymerElement {

  @published Note note;
  @published int position;
  
  KrakowNote.created() : super.created() {
  }
  
  void deleteNote(Event event, Object o, Node target) {
    event.preventDefault();
    print(position);
//    print((event.target as AnchorElement).parent);
//    LIElement actualNote = ((event.target as AnchorElement).parent as LIElement);  
//    int actualIndex = notesWrapper.children.indexOf(actualNote);
//    notes.removeAt(actualIndex);  
//    actualNote.remove();  
//    saveToLocalStorage();
  }
}
