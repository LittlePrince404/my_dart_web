import 'dart:html';
import 'dart:math';

// Should remove tiles from here when they are selected
// otherwise the ratio is off.
const String scrabbleLetters =
    'aaaaaaaaabbccddddeeeeeeeeeeeeffggghhiiiiiiiiijkllllmmnnnnnnooooooooppqrrrrrrssssttttttuuuuvvwwxyyz**';
const Map<String, int> scrabbleValues = {
  'a': 1, 'e': 1, 'i': 1, 'l': 1, 'n': 1,
  'o': 1, 'r': 1, 's': 1, 't': 1, 'u': 1,
  'd': 2, 'g': 2, 'b': 3, 'c': 3, 'm': 3,
  'p': 3, 'f': 4, 'h': 4, 'v': 4, 'w': 4,
  'y': 4, 'k': 5, 'j': 8, 'x': 8, 'q': 10,
  'z': 10, '*': 0
};

final List<ButtonElement> buttons = [];
final Element letterpile = querySelector('#letterpile') as Element;
final Element result = querySelector('#result') as Element;
final Element value = querySelector('#value') as Element;
final ButtonElement clearButton =
    querySelector('#clear-button') as ButtonElement;
int wordValue = 0;

void main() {
  clearButton.onClick.listen(newLetters);
  generateNewLetters();
}

void moveLetter(MouseEvent e) {
  final letter = e.target;
  if (letter is! Element) {
    return;
  }
  if (letter.parent == letterpile) {
    result.children.add(letter);
    wordValue += scrabbleValues[letter.text] ?? 0;
    value.text = '$wordValue';
  } else {
    letterpile.children.add(letter);
    wordValue -= scrabbleValues[letter.text] ?? 0;
    value.text = '$wordValue';
  }
}

void newLetters(Event e) {
  letterpile.children.clear();
  result.children.clear();
  generateNewLetters();
}

void generateNewLetters() {
  final indexGenerator = Random();
  wordValue = 0;
  value.text = '0';
  buttons.clear();
  for (var i = 0; i < 7; i++) {
    final letterIndex = indexGenerator.nextInt(scrabbleLetters.length);
    // Should remove the letter from scrabbleLetters to keep the
    // ratio correct.
    final button = ButtonElement();
    button.classes.add('letter');
    button.onClick.listen(moveLetter);
    button.text = scrabbleLetters[letterIndex];
    buttons.add(button);
    letterpile.children.add(button);
  }
}
