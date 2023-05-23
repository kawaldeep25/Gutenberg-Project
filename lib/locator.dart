import 'package:get_it/get_it.dart';
import 'package:guten/data/providers/booklist_provider.dart';
import 'package:guten/data/remote/api_service.dart';
// import 'package:guten/data/view_model/auth.dart';

import 'package:guten/data/remote/remote_data_source.dart';
import 'package:guten/data/repo/unrestricted_repo.dart';

import 'data/remote/api_service.dart';
import 'data/remote/remote_data_source.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  final RemoteDataSource remoteDataSource = ApiService();
  final UnrestrictedRepository unrestrictedRepository = UnrestrictedRepository(
    remoteDataSource: remoteDataSource,
  );

  /// 💡Tip: There is no point in using 'lazy' singleton
  /// if the instance of class being provided has already
  /// been created.
  ///

  locator.registerLazySingleton<RemoteDataSource>(() => remoteDataSource);
  locator.registerLazySingleton(() => unrestrictedRepository);

  // locator.registerLazySingleton(
  //   () => UnrestrictedRepository(
  //     remoteDataSource: remoteDataSource,
  //   ),
  // );
  locator.registerFactory(() => UnrestrictedProvider());
}
