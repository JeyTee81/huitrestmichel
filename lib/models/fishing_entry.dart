class FishingEntry {
  int? id;
  String fishermanName;
  String boatName;
  DateTime date;
  List<int> categories;
  int quantity;
  int inseminated;

  FishingEntry({
    this.id,
    required this.fishermanName,
    required this.boatName,
    required this.date,
    required this.categories,
    required this.quantity,
    required this.inseminated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fishermanName': fishermanName,
      'boatName': boatName,
      'date': date.toIso8601String(),
      'categories': categories.join(','),
      'quantity': quantity,
      'inseminated': inseminated,
    };
  }

  factory FishingEntry.fromMap(Map<String, dynamic> map) {
    return FishingEntry(
      id: map['id'],
      fishermanName: map['fishermanName'],
      boatName: map['boatName'],
      date: DateTime.parse(map['date']),
      categories: map['categories'].split(',').map((e) => int.parse(e)).toList(),
      quantity: map['quantity'],
      inseminated: map['inseminated'],
    );
  }
}