class AmountFormatter {
  static double format(value) {
    String currentText = value.replaceAll(RegExp(r'[^0-9.]'), '');
    double numericValue = double.tryParse(currentText) ?? 0;
    return numericValue.floorToDouble();
  }
}
