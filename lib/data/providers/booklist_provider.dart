import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guten/data/model/api_response.dart';
import 'package:guten/data/model/books_list.dart';
import 'package:guten/data/remote/api_error_exception.dart';
import 'package:guten/data/repo/unrestricted_repo.dart';
import 'package:guten/locator.dart';
import 'package:guten/utils/theme/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum ResourceStatus {
  Uninitialized,
  Loading,
  Success,
  Failure,
  TokenInvalidatd,
  Empty
}

class UnrestrictedProvider with ChangeNotifier {
  BookList? _booksListResult;
  String? _genreTopic;
  List<BookItem?>? _booksList;
  int _currentPage = 1;
  String? _searchedString;
  TextEditingController searchCtrl = TextEditingController(text: '');
  bool pageLoader = false;
  bool bookOpenError = false;
  ResourceStatus _todoActionState = ResourceStatus.Uninitialized;
  ResourceStatus get todoActionState => _todoActionState;
  BookList? get booksListResult => _booksListResult;
  final UnrestrictedRepository? unrestrictedRepository;

  UnrestrictedProvider({
    UnrestrictedRepository? unrestrictedRepository,
  }) : unrestrictedRepository = locator<UnrestrictedRepository>();

  /* get list of book object */
  List<BookItem?> get getBooksList {
    return _booksList!;
  }

  /* Getter for genre title */
  String get genreTitle {
    return _genreTopic!;
  }

  Future<ApiResponse<BookList>?> getBooksByGenre(String genreTitle) async {
    _todoActionState = ResourceStatus.Loading;
    notifyListeners();
    var apiResponse = await unrestrictedRepository!.getBooks(genreTitle);
    // _booksList = [];
    if (apiResponse!.status == 200) {
      _todoActionState = ResourceStatus.Success;
      _booksListResult = apiResponse.data!;
      _booksList = apiResponse.data!.results;
      _genreTopic = genreTitle;
    } else {
      _todoActionState = ResourceStatus.Failure;
    }
    notifyListeners();
    return apiResponse;
  }

  /* Function to clear search and reinitialize api to get books list */
  void clearSearch() {
    if (_searchedString != null || _searchedString != '') {
      _searchedString = null;
      searchCtrl.text = '';
      searchCtrl.clear();
      _currentPage = 0;
      _booksList!.clear();
      notifyListeners();
      getMoreBooks();
    }
  }

  /* API to get list of books based on page along with other params */
  Future<void> getMoreBooks() async {
    if (_booksListResult!.next != '' || _currentPage < 1) {
      pageLoader = true;
      notifyListeners();
      _currentPage = _currentPage + 1;
    } else {
      return;
    }
    var apiResponse = await unrestrictedRepository!
        .getMoreBooks(genreTitle, _currentPage, _searchedString);

    if (apiResponse!.status == 200) {
      _booksListResult = apiResponse.data;
      _booksList!.addAll(apiResponse.data!.results);
      pageLoader = false;
      notifyListeners();
    } else {
      pageLoader = false;
      notifyListeners();
      throw APIErrorException('Oops Some Error Occurred!!');
    }
  }

  /*
    API to get list of books based on search
    @params (String searched_keyword)
  */
  Future<void> onSearchFunction(String key) async {
    _currentPage = 1;
    // pageLoader = true;
    notifyListeners();
    _searchedString = key;
    var apiResponse = await unrestrictedRepository!
        .getBooksBySearch(genreTitle, _searchedString);

    if (apiResponse!.status == 200) {
      _booksListResult = apiResponse.data;
      _booksList = apiResponse.data!.results;
      // pageLoader = false;
      notifyListeners();
    } else {
      // pageLoader = false;
      notifyListeners();
      throw APIErrorException('Oops Some Error Occurred!!');
    }
  }

  /*
    API to get single book detail
    @params (int book_id)
  */
  Future<bool> getBookDetails(int id) async {
    var apiResponse =
        await unrestrictedRepository!.getBookDetails(genreTitle, id.toString());

    if (apiResponse!.status == 200) {
      BookItem bookDetail = apiResponse.data!;

      String url = '';

      print('object is ${bookDetail.formats.toJson()}');

      if (bookDetail.formats.textHtml != '') {
        launchUrl(Uri.parse(bookDetail.formats.textHtml));
        return true;
      } else if (bookDetail.formats.textHtmlCharsetIso88591 != '') {
        launchUrlString(bookDetail.formats.textHtmlCharsetIso88591);
        return true;
      } else if (bookDetail.formats.textHtmlCharsetUsAscii != '') {
        launchUrlString(bookDetail.formats.textHtmlCharsetUsAscii);
        return true;
      } else if (bookDetail.formats.textHtmlCharsetUtf8 != '') {
        launchUrlString(bookDetail.formats.textHtmlCharsetUtf8);
        return true;
      } else if (bookDetail.formats.applicationPdf != '') {
        launchUrlString(bookDetail.formats.applicationPdf);
        return true;
      } else if (bookDetail.formats.textPlain != '') {
        launchUrlString(bookDetail.formats.textPlain);
        return true;
      } else if (bookDetail.formats.textPlainCharsetIso88591 != '') {
        launchUrlString(bookDetail.formats.textPlainCharsetIso88591);
        return true;
      } else if (bookDetail.formats.textPlainCharsetUsAscii != '') {
        launchUrlString(bookDetail.formats.textPlainCharsetUsAscii);
        return true;
      } else if (bookDetail.formats.applicationZip != '' ||
          bookDetail.formats.applicationEpubZip != '') {
        return false;
      } else {
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url);
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }

  /* Get Assets based on Genre Title */
  String getAssetByGenre() {
    var genre = genreTitle.toLowerCase();
    if (genre == 'fiction') {
      return AppAssets.fiction;
    } else if (genre == 'drama') {
      return AppAssets.drama;
    } else if (genre == 'humour') {
      return AppAssets.humour;
    } else if (genre == 'politics') {
      return AppAssets.politics;
    } else if (genre == 'philosophy') {
      return AppAssets.philosophy;
    } else if (genre == 'history') {
      return AppAssets.history;
    } else if (genre == 'adventure') {
      return AppAssets.adventure;
    } else {
      return AppAssets.cancel;
    }
  }
}
