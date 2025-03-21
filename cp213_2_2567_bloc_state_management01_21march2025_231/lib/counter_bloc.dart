import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterValueState> {
  CounterBloc() : super(CounterValueState(0)) {
    on<IncrementEvent>((event, emit) {
      emit(CounterValueState(state.counter + 1));
    });

    on<DecrementEvent>((event, emit) {
      emit(CounterValueState(state.counter - 1));
    });

    on<MultiplyEvent>((event, emit) {
      emit(CounterValueState(state.counter * 2)); 
    });
  }
}
