import 'dart:io';

class Stack<T> {
  List<T> _stack = [];

  // Method to push an element onto the stack
  void push(T element) {
    _stack.add(element);
  }

  // Method to pop an element from the stack
  T? pop() {
    if (isEmpty()) {
      return null; // Stack is empty
    }
    return _stack.removeLast();
  }

  // Method to check if the stack is empty
  bool isEmpty() {
    return _stack.isEmpty;
  }

  // Method to display the stack contents
  void displayStack() {
    print('Stack: $_stack');
  }
}

void main() {
  Stack<int> stack = Stack<int>();

  while (true) {
    stdout.write('Enter "push" to push an element, "pop" to pop an element, or "quit" to exit: ');
    String? choice = stdin.readLineSync();

    if (choice == 'push') {
      stdout.write('Enter the element to push onto the stack: ');
      int? element = int.tryParse(stdin.readLineSync() ?? '');
      if (element != null) {
        stack.push(element);
        stack.displayStack();
      } else {
        print('Invalid input. Please enter a valid integer.');
      }
    } else if (choice == 'pop') {
      int? popped = stack.pop();
      if (popped != null) {
        print('Popped element: $popped');
        stack.displayStack();
      } else {
        print('Stack is empty.');
      }
    } else if (choice == 'quit') {
      print('Exiting program.');
      break;
    } else {
      print('Invalid choice. Please enter "push", "pop", or "quit".');
    }
  }
}
