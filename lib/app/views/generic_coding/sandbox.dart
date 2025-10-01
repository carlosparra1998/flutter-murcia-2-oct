TipAndTricks instance1 = TipAndTricks<String, int>("data", [1, 2, 3]);
TipAndTricks instance2 = TipAndTricks<List<double>, List<bool>>(
  [1.1, 2.2, 3.3],
  [
    [true, false],
    [false, true],
    [false, true, false],
  ],
);

class TipAndTricks<A, B> {
  A data;
  List<B> listData;

  TipAndTricks(this.data, this.listData);

  @override
  String toString() {
    return '\n=> Tengo un campo data de tipo ${data.runtimeType} = $data\n'
        '\n=> Tengo un campo data de listData ${listData.runtimeType} de tamaño ${listData.length} = $listData';
  }
}
