enum FeedCardType {
  compact('Compact'),
  card('Card'),
  grid('Grid');

  final String value;
  const FeedCardType(this.value);
  factory FeedCardType.fromJson(String value) => values.firstWhere((e) => e.value == value);

  String toJson() => value;
  @override
  String toString() => value;
}
