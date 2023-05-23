import 'package:guten/data/model/api_response.dart';
import 'package:guten/data/model/books_list.dart';

abstract class RemoteDataSource {
  Future<ApiResponse<BookList>?> getBooks(String category);
  Future<ApiResponse<BookList>?> getBookBySearch(String category, String? key);
  Future<ApiResponse<BookList>?> getMoreBooks(
      String category, int page, String? key);
  Future<ApiResponse<BookItem>?> getBookDetails(String category, String id);
}
