enum FeedCardType {
  compact('Compact'),
  card('Card'),
  grid('Grid');

  final String value;
  const FeedCardType(this.value);
  factory FeedCardType.fromJson(dynamic value) {
    return value is int ? values[value] : values.firstWhere((e) => e.value == value);
  }

  String toJson() => value;

  String toString() => value;
}
