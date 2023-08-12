class Artist {
  final String id;
  final String name;

  const Artist({
    required this.id,
    required this.name,
  });

  static const artists = [
    Artist(id: '1', name: 'Adel Dalking'),
    Artist(id: '2', name: 'Tailor Swift'),
    Artist(id: '3', name: "Mouh milano"),
    Artist(id: '4', name: "Djalil Palermo"),
    Artist(id: '5', name: "Djalil Abra"),
  ];
}
