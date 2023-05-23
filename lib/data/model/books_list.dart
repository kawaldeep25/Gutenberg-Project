import 'package:guten/data/model/safe_convert.dart';

class BookList {
  final int count;
  final String next;
  final String previous;
  final List<BookItem> results;

  BookList({
    this.count = 0,
    this.next = "",
    this.previous = "",
    required this.results,
  });

  factory BookList.fromJson(Map<String, dynamic>? json) => BookList(
        count: asT<int>(json, 'count'),
        next: asT<String>(json, 'next'),
        previous: asT<String>(json, 'previous'),
        results: asT<List>(json, 'results')
            .map((e) => BookItem.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'results': results.map((e) => e.toJson()).toList(),
      };
}

class BookItem {
  final int id;
  final List<AuthorsItem> authors;
  final List<dynamic> bookshelves;
  final int downloadCount;
  final Formats formats;
  final List<String> languages;
  final String mediaType;
  final List<String> subjects;
  final String title;

  BookItem({
    this.id = 0,
    required this.authors,
    required this.bookshelves,
    this.downloadCount = 0,
    required this.formats,
    required this.languages,
    this.mediaType = "",
    required this.subjects,
    this.title = "",
  });

  factory BookItem.fromJson(Map<String, dynamic>? json) => BookItem(
        id: asT<int>(json, 'id'),
        authors: asT<List>(json, 'authors')
            .map((e) => AuthorsItem.fromJson(e))
            .toList(),
        bookshelves:
            asT<List>(json, 'bookshelves').map((e) => e.toString()).toList(),
        downloadCount: asT<int>(json, 'download_count'),
        formats: Formats.fromJson(asT<Map<String, dynamic>>(json, 'formats')),
        languages:
            asT<List>(json, 'languages').map((e) => e.toString()).toList(),
        mediaType: asT<String>(json, 'media_type'),
        subjects: asT<List>(json, 'subjects').map((e) => e.toString()).toList(),
        title: asT<String>(json, 'title'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'authors': authors.map((e) => e.toJson()).toList(),
        'bookshelves': bookshelves.map((e) => e).toList(),
        'download_count': downloadCount,
        'formats': formats.toJson(),
        'languages': languages.map((e) => e).toList(),
        'media_type': mediaType,
        'subjects': subjects.map((e) => e).toList(),
        'title': title,
      };
}

class AuthorsItem {
  final int birthYear;
  final int deathYear;
  final String name;

  AuthorsItem({
    this.birthYear = 0,
    this.deathYear = 0,
    this.name = "",
  });

  factory AuthorsItem.fromJson(Map<String, dynamic>? json) => AuthorsItem(
        birthYear: asT<int>(json, 'birth_year'),
        deathYear: asT<int>(json, 'death_year'),
        name: asT<String>(json, 'name'),
      );

  Map<String, dynamic> toJson() => {
        'birth_year': birthYear,
        'death_year': deathYear,
        'name': name,
      };
}

class Formats {
  final String applicationEpubZip;
  final String textPlainCharsetUtf8;
  final String imageJpeg;
  final String applicationZip;
  final String applicationRdfXml;
  final String textHtmlCharsetUtf8;
  final String applicationXMobipocketEbook;
  final String textPlainCharsetUsAscii;
  final String textPlainCharsetIso88591;
  final String textHtmlCharsetIso88591;
  final String textHtmlCharsetUsAscii;
  final String textPlain;
  final String textRtf;
  final String textHtml;
  final String applicationPdf;

  Formats(
      {this.applicationEpubZip = '',
      this.textPlainCharsetUtf8 = '',
      this.imageJpeg = '',
      this.applicationZip = '',
      this.applicationRdfXml = '',
      this.textHtmlCharsetUtf8 = '',
      this.applicationXMobipocketEbook = '',
      this.textPlainCharsetUsAscii = '',
      this.textPlainCharsetIso88591 = '',
      this.textHtmlCharsetIso88591 = '',
      this.textHtmlCharsetUsAscii = '',
      this.textPlain = '',
      this.textRtf = '',
      this.textHtml = '',
      this.applicationPdf = ''});

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        applicationEpubZip: json.containsKey('application/epub+zip')
            ? json['application/epub+zip']
            : '',
        textPlainCharsetUtf8: json.containsKey('text/plain; charset=utf-8')
            ? json['text/plain; charset=utf-8']
            : '',
        imageJpeg: json.containsKey('image/jpeg') ? json['image/jpeg'] : '',
        applicationZip:
            json.containsKey('application/zip') ? json['application/zip'] : '',
        applicationRdfXml: json.containsKey('application/rdf+xml')
            ? json['application/rdf+xml']
            : '',
        textHtmlCharsetUtf8: json.containsKey('text/html; charset=utf-8')
            ? json['text/html; charset=utf-8']
            : '',
        applicationXMobipocketEbook:
            json.containsKey('application/x-mobipocket-ebook')
                ? json['application/x-mobipocket-ebook']
                : '',
        textPlainCharsetUsAscii:
            json.containsKey('text/plain; charset=us-ascii')
                ? json['text/plain; charset=us-ascii']
                : '',
        textPlainCharsetIso88591:
            json.containsKey('text/plain; charset=iso-8859-1')
                ? json['text/plain; charset=iso-8859-1']
                : '',
        textHtmlCharsetIso88591:
            json.containsKey('text/html; charset=iso-8859-1')
                ? json['text/html; charset=iso-8859-1']
                : '',
        textHtmlCharsetUsAscii: json.containsKey('text/html; charset=us-ascii')
            ? json['text/html; charset=us-ascii']
            : '',
        textPlain: json.containsKey('text/plain') ? json['text/plain'] : '',
        textRtf: json.containsKey('text/rtf') ? json['text/rtf'] : '',
        textHtml: json.containsKey('text/html') ? json['text/html'] : '',
        applicationPdf:
            json.containsKey('application/pdf') ? json['application/pdf'] : '',
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['application/epub+zip'] = this.applicationEpubZip;
    data['text/plain; charset=utf-8'] = this.textPlainCharsetUtf8;
    data['image/jpeg'] = this.imageJpeg;
    data['application/zip'] = this.applicationZip;
    data['application/rdf+xml'] = this.applicationRdfXml;
    data['text/html; charset=utf-8'] = this.textHtmlCharsetUtf8;
    data['application/x-mobipocket-ebook'] = this.applicationXMobipocketEbook;
    data['text/plain; charset=us-ascii'] = this.textPlainCharsetUsAscii;
    data['text/plain; charset=iso-8859-1'] = this.textPlainCharsetIso88591;
    data['text/html; charset=iso-8859-1'] = this.textHtmlCharsetIso88591;
    data['text/html; charset=us-ascii'] = this.textHtmlCharsetUsAscii;
    data['text/plain'] = this.textPlain;
    data['text/rtf'] = this.textRtf;
    data['text/html'] = this.textHtml;
    data['application/pdf'] = this.applicationPdf;
    return data;
  }
}
