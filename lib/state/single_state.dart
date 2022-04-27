library dart_utils;

import 'dart:async';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class SingleState<T> {

  SingleState();

  SingleState.initial(
      this.initialValue
      ) {
    setState(initialValue);
  }

  late T initialValue;
  late BehaviorSubject<T> _subject = BehaviorSubject<T>();

  Stream<T> get stream => _subject.stream;

  T get value => _subject.value;

  void setState(T _newState) {
    try {
      _subject.sink.add(_newState);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  void resetState() {
    _subject = BehaviorSubject<T>();
  }

  T getState() {
    return value;
  }

  Stream<T> getStream() {
    return stream;
  }

  StreamSubscription<T> listen() {
    return stream.listen((T data) => data);
  }

  Future<bool> addStream(Stream<T> _stream) async {
    final bool _v = await _subject.addStream(_stream).then((void v) => true);
    return _v;
  }

  Future<void> dispose() async {
    await _subject.close();
  }

  bool hasValue() {
    return _subject.hasValue;
  }
}