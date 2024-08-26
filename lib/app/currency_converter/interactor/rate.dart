class Rate {
  final String currency;
  final dynamic rate;

  Rate({
    required this.currency,
    required this.rate,
  });

  @override
  String toString() => 'Rate(currency: $currency, rate: $rate)';
}
