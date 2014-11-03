import 'package:polymer/polymer.dart';
import 'note.dart';

/**
 * A Polymer krakow-note element.
 */
@CustomTag('krakow-note')
class KrakowNote extends PolymerElement {

  @published Note note;
  
  KrakowNote.created() : super.created() {
  }
}
