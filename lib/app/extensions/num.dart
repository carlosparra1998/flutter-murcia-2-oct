extension NumExtension on num{
  String toMoney() => '${toStringAsFixed(2)} €';
}