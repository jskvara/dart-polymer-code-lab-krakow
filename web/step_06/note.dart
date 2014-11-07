library krakow.model;

import 'dart:convert';

class Note {
  String text;
  
  Note(this.text);
  
  static List fromJson(String jsonString) {
    List notes = new List();    
    Map notesJsonMap = JSON.decode(jsonString);
    List notesJsonList = notesJsonMap["notes"];
    
    for (Map noteJsonMap in notesJsonList) {
      Note note = new Note(noteJsonMap["text"]);
      notes.add(note);
    }
    return notes;
  }
  
  static String toJson(List notes) {
    Map notesJsonMap = new Map();
    List notesJsonList = new List();
    
    for (Note note in notes) {
      Map noteJsonMap = new Map();
      noteJsonMap["text"] = note.text;
      notesJsonList.add(noteJsonMap);
    }
    
    notesJsonMap["notes"] = notesJsonList;
    return JSON.encode(notesJsonMap);
  }
}
