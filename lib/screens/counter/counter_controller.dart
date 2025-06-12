class CounterController {
  int counter = 0;

  void increment() {
    counter++;
  }

  void decrement() {
    if (counter > 0) counter--;
  }

  void reset() {
    counter = 0;
  }

  bool canDecrement() => counter > 0;
}
