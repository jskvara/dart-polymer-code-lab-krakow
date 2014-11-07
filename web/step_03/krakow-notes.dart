import 'package:polymer/polymer.dart';
import 'note.dart';

/**
 * A Polymer krakow-notes element.
 */
@CustomTag('krakow-notes')
class KrakowNotes extends PolymerElement {

  @observable List notes = toObservable([]);

  KrakowNotes.created() : super.created() {
    notes.add(new Note('Learn Dart'));
    notes.add(new Note('Learn Polymer'));
  }
}
