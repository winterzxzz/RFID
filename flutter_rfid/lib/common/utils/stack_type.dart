class DataStack<T> {
  final List<T> _stack = [];

  /// Adds an element to the top of the stack
  void push(T element) {
    _stack.add(element);
  }

  /// Removes and returns the top element of the stack
  /// Throws an error if the stack is empty
  T pop() {
    if (_stack.isEmpty) {
      throw StateError("Cannot pop from an empty stack");
    }
    return _stack.removeLast();
  }

  /// Returns the top element without removing it
  /// Throws an error if the stack is empty
  T peek() {
    if (_stack.isEmpty) {
      throw StateError("Cannot peek from an empty stack");
    }
    return _stack.last;
  }

  /// return element under the top nearest
  T peek2() {
    if (_stack.length < 2) {
      throw StateError("Cannot peek2 from an empty stack");
    }
    return _stack[_stack.length - 2];
  }

  /// Checks if the stack is empty
  bool get isEmpty => _stack.isEmpty;

  /// Checks if the stack has elements
  bool get isNotEmpty => _stack.isNotEmpty;

  /// Returns the current size of the stack
  int get size => _stack.length;

  /// Clears all elements from the stack
  void clear() {
    _stack.clear();
  }

  // copy with
  DataStack<T> copyWith() {
    return DataStack<T>().._stack.addAll(_stack);
  }

  @override
  String toString() => _stack.toString();
}
