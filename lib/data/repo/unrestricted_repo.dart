import 'package:flutter/material.dart';
import 'package:guten/data/model/api_response.dart';
import 'package:guten/data/model/books_list.dart';
import 'package:guten/data/remote/remote_data_source.dart';

class UnrestrictedRepository {
  RemoteDataSource? _remoteDataSource;

  UnrestrictedRepository({@required remoteDataSource})
      : assert(remoteDataSource != null) {
    _remoteDataSource = remoteDataSource;
  }

  Future<ApiResponse<BookList>?> getBooks(String category) async {
    return await _remoteDataSource!.getBooks(category);
  }

  Future<ApiResponse<BookList>?> getBooksBySearch(
      String category, String? key) async {
    return await _remoteDataSource!.getBookBySearch(category, key);
  }

  Future<ApiResponse<BookList>?> getMoreBooks(
      String category, int page, String? key) async {
    return await _remoteDataSource!.getMoreBooks(category, page, key);
  }

  Future<ApiResponse<BookItem>?> getBookDetails(
      String category, String id) async {
    return await _remoteDataSource!.getBookDetails(category, id);
  }
}
