# Notes Application Dart + Polymer Code Lab Kraków 2014

The goal of this code lab is to create note-taking application in **Dart** and **Polymer**. We create simple application which can add notes, delete selected note or all notes in the list and we also try local storage to save the notes into the browser.

You will learn:
* how to write applications in Dart and Polymer
* how to use Polymer Core and Paper elements
* how to write your own Polymer elements
* how to integrate Polymer elements into your application

Download the prepared project from Github and open it in Dart editor. We prepared everything important for you so you don't have to solve any CSS styling and HTML structure, and you can directly explore how to write Dart application.

Project is divided into steps according to this Code Lab. Try to run the application from _step_06/_ and see how it works.

![Notes application](https://github.com/jskvara/dart-polymer-code-lab-krakow/blob/master/notes_app.png)

## Step 1 - Empty project
Start in _step_01/_. This is a basic project with HTML template and styles and only printing simple counter Polymer element. 

We update this step with functionality and at the end we will have nice notes application.

## Step 2 - Create new Polymer element + using Paper + Core elements

In this step we create our own element and we learn, how to use Polymer Paper and Core elements in our application.

First **rename** `clickcounter.html` to `krakow-notes.html` and `clickcounter.dart` to `krakow-notes.dart`.

Then you need to change your import in `index.html` file:

```html
	<!-- import the notes element -->
	<link rel="import" href="krakow-notes.html">
```

And use our element in HTML body:

```html
	<body>
		<krakow-notes></krakow-notes>

		...
	</body>
```

The whole `index.html` file looks like this:

```html
<!DOCTYPE html>

<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes app</title>

    <!-- include the web_components polyfills with support for Dart. -->
    <script src="packages/web_components/platform.js"></script>

    <!-- import the notes element -->
    <link rel="import" href="krakow-notes.html">
    
    <link rel="stylesheet" href="index.css">
  </head>
  <body>
    <krakow-notes></krakow-notes>

    <!-- bootstrap polymer -->
    <script type="application/dart">export 'package:polymer/init.dart';</script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>

```


In file `krakow-notes.html` we need to make several changes. At first, we need rename our element to `krakow-notes`. Change element definition in `<polymer-element>` tag to `krakow-notes`, which should be same as the name of file.

```html
<polymer-element name="krakow-notes">
	...
</polymer-element>
```

We also need to change our `<script>` element to use `krakow-notes.dart` file.

```html
	<script type="application/dart" src="krakow-notes.dart"></script>
```

And some CSS changes:
```html
	<style>
		#notes-delete-all {
			background: red;
		}
		core-toolbar h2 {
			color: white;
		}
		core-toolbar paper-input {
			line-height: 1em;
			width: 100%;
		}
</style>
```

Now, we can start adding Polymer Core and Paper elements to our element. First, we need to import elements, which we want to use. We will use paper input, paper button, core toolbar and core icon elements.

At the beggining of the file, we need to add the following import statements:
```html
<link rel="import" href="packages/paper_elements/paper_input.html">
<link rel="import" href="packages/paper_elements/paper_button.html">
<link rel="import" href="packages/core_elements/core_icon.html">
<link rel="import" href="packages/core_elements/core_toolbar.html">
```

In our template body, we can now easily use these elements. We will have `core-toolbar` element with three sub-elements: title, input box for adding new note and button, which deletes all.

Last element in `krakow-notes` will be list of all notes, but we will add this in step 3. For now, we will insert only empty `<div>` element. 

HTML body of our element will be the following:

```html
    <core-toolbar>
      <h2>Notes app</h2>

      <span flex>
        <paper-input floatinglabel label="Enter note"></paper-input>
      </span>

      <paper-button raised id="notes-delete-all">
        <core-icon icon="clear">
        </core-icon>
        Delete all
      </paper-button>
    </core-toolbar>

    <div class="content">

    </div>
```

Last thing, that is missing is updating `krakow-notes.dart` file. We need to rename our element to `krakow-notes` and delete unused code. Content of the file will be following:

```dart
import 'package:polymer/polymer.dart';

/**
 * A Polymer krakow-notes element.
 */
@CustomTag('krakow-notes')
class KrakowNotes extends PolymerElement {

  KrakowNotes.created() : super.created() {
  }

}
```

You should be able to run the project now. If you select `index.html` file and click on green button run. You should see our appplication with toolbar.

## Step 3 - Create new Polymer element and bind model with template

In this step we create another element `krakow-note`, which will be single item in our list of notes. And we use this element as a template for list of our notes from Dart.

First, we create new element in file `krakow-note.html`. We will use the following paper elements: paper button, papaer icon button, paper shadow and paper ripple.

Add these imports into our newly created file `krakow-note.html`:

```html
<!-- import polymer-element's definition -->
<link rel="import" href="packages/polymer/polymer.html">
<link rel="import" href="packages/paper_elements/paper_button.html">
<link rel="import" href="packages/paper_elements/paper_icon_button.html">
<link rel="import" href="packages/paper_elements/paper_shadow.html">
<link rel="import" href="packages/paper_elements/paper_ripple.html">
```

We add element declaration with `<script>` tag that links our file with `Dart` code:

```html
<polymer-element name="krakow-note">
  <template>
    ...
  </template>
  <script type="application/dart" src="krakow-note.dart"></script>
</polymer-element>
```

We add some css styles:
```html
    <style>
      .note {
        padding: 0.5em;
        margin: 0.5em;
      }
      .note .note-text {
        margin: 0.5em;
        font-size: 2em;
      }
      paper-icon-button.delete {
        color: red;
        float: right;
      }
    </style>
```

And finally we can add Paper elements. We start with `<div>` element, which will have horizontal layout:

```html
    <div class="note" layout horizontal>
      ...
    </div>
```

Inside this element we will add another `<div>` element with our note's text and with nice ripple effect. Next we add delete icon button. The last element we add to `krakow-note` is paper shadow element with z-index set to 2.

```html
    <div class="note" layout horizontal>
      <div flex class="note-text">
        {{note.text}}
        <paper-ripple fit></paper-ripple>
      </div>
      <div>
        <paper-icon-button icon="clear" class="delete"></paper-icon-button>
      </div>
      <paper-shadow z="2"></paper-shadow>
    </div>
```

Our `krakow-note.dart` file is similar to the previous element. We only add `Note` property with `@published` annotation. This annotation automatically sets `note` variable from element attributes (we will see this later).

The content of `krakow-note.dart` will be:

```dart
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

```

Last file in this step is `note.dart`, which is simple `Note` class only with `String` variable `text`:

```dart
library krakow.model;

class Note {
  String text;

  Note(this.text);
}
```

Now we can use our new element `krakow-note`. We want to use this element for each item in notes list. So we can easily use polymer `template` tag. In `krakow-notes.html` you need to add inside content `<div>` this code:

```html
      <template repeat="{{note in notes }}">
        <krakow-note note="{{note}}"></krakow-note>
      </template>
```

For every note object in notes array we render `krakow-note` element, with `note` attribute, which sets the note object into our `@published` property in `krakow-note` element.

In `krakow-notes.dart` file, we need to declare our `notes` collection and we can add some `Note` objects. When we add `@observable` annotation to our property, it will be availabe in our template and every change will be propragated to template. We need to declare this list as observable (method `toObservable()`) instead of normal `List`.

```dart
  @observable List notes = toObservable([]);

  KrakowNotes.created() : super.created() {
    notes.add(new Note('Learn Dart'));
    notes.add(new Note('Learn Polymer'));
  }
```

## Step 4 - Adding new notes

In this step we add a method, that will add a new note to our list of notes.

In `krakow-notes.html` file we add `on-change` attribute to `paper-input` element, which will call `createNote` method from our `krakow-notes.dart` file.

```html
        <paper-input floatinglabel label="Enter note" on-change="{{createNote}}"></paper-input>
```

And in `krakow-notes.dart` file we add new method `createNote`. This method is similar to `jQuery` methods from `JavaScript` and has three parameters: event, data and target. When this method is run, we check if value is not empaty and add data from our input to the list of our notes.

```dart
  void createNote(Event event, Object noteText, PaperInput target) {
    String noteText = target.value;
    if (noteText.isNotEmpty) {
      notes.add(new Note(noteText));
      target.inputValue = '';
      target.commit();
    }
  }
```

When you run your application, you should be able to add new notes to our list.

## Step 5 - Deleting notes

In this step we add methods, that delete single note from our list and method, that deletes all the notes.

We will start with Delete all button. We need to add `on-click` attribute to our delete button in `krakow-notes.html` file:

```html
      <paper-button raised id="notes-delete-all" on-click="{{deleteAll}}">...</paper-button>
```

And in `krakow-notes.dart` file we define new method `deleteAll`, which removes all data from our `notes` collection:

```dart
  void deleteAll(Event event) {
    notes.clear();
  }
```

Now we need to add delete method for signle note. Before we start with this method, we need to add indexes to our notes in list, because we need to know, which note we want to delete.

We will add `enumerate` filter to our notes collection in template file `krakow-notes.html`. This filter creates two objects from our notes. We will have `note.index`, which is index in our collection and `note.value`, which is the actual value of `note` (same as `note` without the filter). We can change our code to:

```html
      <template repeat="{{note in notes | enumerate }}">
        <krakow-note note="{{note.value}}" index="{{note.index}}"></krakow-note>
      </template>
```

We also need to add this new `index` attribute to our `krakow-note` element, addint property `index` with `@published` annotation:

```dart
  @published int index;
```

Now we can add `on-click` attribute to `paper-icon-button` element in `krakow-note` to call our method `deleteNote`:

```html
        <paper-icon-button icon="clear" class="delete" on-click="{{deleteNote}}"></paper-icon-button>
```

And in `krakow-note.dart` we declare this method. Because the list of our notes is in parent element, we can fire our custom event with name `delete-note` and with index of deleted note.

```dart
  void deleteNote(Event event, Object value, PaperIconButton target) {
    this.fire('delete-note', detail: {'index': index});
  }
```

Now we need to catch this event. We can declare that our element `krakow-notes` should listen for these events and when this event is fired, we can call our method in `krakow-notes` element. We can use `on-delete-note` attribute in element definition. The syntax for this attribute is `on-` and name of event. After we catch any event, we can call our custom method from that element. We need to change our `krakow-notes` element declaration:

```html
<polymer-element name="krakow-notes" on-delete-note="{{deleteNote}}">
  ...
</polymer-element>
```

And we can add new method `deleteNote` to `krakow-notes.dart` file. We get the index of note, which should be deleted and we can easily remove note on that index from our collection.

```dart
  void deleteNote(Event event, var note) {
    int index = note['index'];
    notes.removeAt(index);
  }
```

## Step 6 - Saving to local storage

We can improve our application to save all data to brower local storage, so when user closes or refreshes browser, tha data are still saved in browser. And if user opens the browser again he doesn't loose the data.

Because data in local storage are saved as string. We need to add methods, that transform our notes to and from JSON string. We add methods `fromJson` and `toJson` to our `Notes` class in `note.dart` file. Don't forget to import `dart:convert` package.

```dart
import 'dart:convert';

...

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
```

Now we need to add methods to `krakow-notes.dart` file. We add `loadFromLocalStorage` and `saveToLocalStorage` methods, which use Dart `window` object, that handles saving and loading the data. We just need to convert our data to and from JSON.

```dart
final String NOTES_LIST = "notesList";

...

  void loadFromLoacalStorage() {
    if (window.localStorage[NOTES_LIST] != null) {
      notes = toObservable(Note.fromJson(window.localStorage[NOTES_LIST]));
    }
  }

  void saveToLocalStorage() {
    window.localStorage[NOTES_LIST] = Note.toJson(notes);
  }
```

Last thing, that we need to do is to add our new methods to our code. When data are changed in `krakow-notes` file. We load the data when the element is created: page is (re)loaded and save the data when we add or delete the note.

```dart
  KrakowNotes.created() : super.created() {
    loadFromLoacalStorage();
  }

  void createNote(Event event, Object noteText, PaperInput target) {
      ...
      notes.add(new Note(noteText));
      saveToLocalStorage();
      target.inputValue = '';
      ...
  }

  void deleteNote(Event event, var note) {
    ...
    saveToLocalStorage();
  }

  void deleteAll(Event event) {
    notes.clear();
    saveToLocalStorage();
  }
```

Now when you refresh your browser, you should see all your notes, that were previously saved in your browser.
