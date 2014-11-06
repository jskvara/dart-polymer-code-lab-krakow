import 'package:polymer/polymer.dart';
import 'dart:html';
import 'note.dart';
import 'dart:html';
import 'package:paper_elements/paper_icon_button.dart';

/**
 * A Polymer krakow-note element.
 */
@CustomTag('krakow-note')
class KrakowNote extends PolymerElement {

  @published Note note;
  @published int index;

  KrakowNote.created() : super.created() {
  }

  void deleteNote(Event event, Object value, PaperIconButton target) {
    this.fire('delete-note', detail: {'index': index});
  }
}
