abstract class CounterState {}

class CounterValueState extends CounterState {
  int counter;
  int get getcounter => counter;
  CounterValueState(this.counter);
}
