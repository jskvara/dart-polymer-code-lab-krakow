import 'package:polymer/polymer.dart';
import 'dart:html';
import 'note.dart';

/**
 * A Polymer krakow-note element.
 */
@CustomTag('krakow-note')
class KrakowNote extends PolymerElement {

  @published Note note;
  @published int index;

  KrakowNote.created() : super.created() {
  }

  void deleteNote(Event event) {
    this.fire('delete-note', detail: {'index': index});
  }
}
