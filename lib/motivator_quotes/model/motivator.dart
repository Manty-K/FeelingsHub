class Motivator {
  final String name;
  final List<String> quotes;

  Motivator({required this.name, required this.quotes});

  factory Motivator.fromJson(Map<String, dynamic> json) {
    return Motivator(
        name: json['name'],
        quotes: (json['quotes'] as List).map((e) => e as String).toList());
  }
}
