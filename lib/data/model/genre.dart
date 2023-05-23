class Genre {
  final String? genreIcon;
  final String? genreTitle;

  Genre(this.genreIcon, this.genreTitle);

  @override
  String toString() {
    return 'Genre{genreIcon: $genreIcon, genreTitle: $genreTitle}';
  }
}
