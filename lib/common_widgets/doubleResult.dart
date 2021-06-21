class DoubleResponse<T, R> {
  DoubleResponse(this.data1, this.data2);
  final T data1;
  final R data2;

  DoubleResponse<T, R> copyWith({
    T data1,
    R data2,
  }) {
    return DoubleResponse<T, R>(
      data1 ?? this.data1,
      data2 ?? this.data2,
    );
  }
}

class TripleResponse<T, R, P> {
  TripleResponse(
    this.data1,
    this.data2,
    this.data3,
  );
  final T data1;
  final R data2;
  final P data3;

  TripleResponse<T, R, P> copyWith({
    T data1,
    R data2,
    P data3,
  }) {
    return TripleResponse<T, R, P>(
      data1 ?? this.data1,
      data2 ?? this.data2,
      data3 ?? this.data3,
    );
  }
}
