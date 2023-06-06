import 'dart:html';

final InputElement toDoInput = querySelector('#to-do-input') as InputElement;
final UListElement toDoList = querySelector('#to-do-list') as UListElement;
final ButtonElement deleteAll = querySelector('#delete-all') as ButtonElement;

void main() {
  toDoInput.onChange.listen(addToDoItem);
  deleteAll.onClick.listen((_) => toDoList.children.clear());
}

void addToDoItem(Event e) {
  final newToDo = LIElement()..text = toDoInput.value;
  newToDo.onClick.listen((_) => newToDo.remove());
  toDoInput.value = '';
  toDoList.children.add(newToDo);
}
