import 'package:get_it/get_it.dart';
import 'package:learning_2_10c/modules/posts/datasource/post_remote_data_source.dart';
import 'package:learning_2_10c/modules/posts/repositories/post_repository.dart';
import 'package:learning_2_10c/use_cases/create_post.dart';
import 'package:learning_2_10c/use_cases/delete_post.dart';
import 'package:learning_2_10c/use_cases/get_post.dart';
import 'package:learning_2_10c/use_cases/update_post.dart';
import 'dio_client.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Registro de dependencias
  locator.registerLazySingleton(
      () => DioClient(baseUrl: 'https://jsonplaceholder.typicode.com/posts'));

  // Data Sources
  locator.registerFactory<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(dioClient: locator()));

  // Repositorios
  locator.registerFactory<PostRepository>(
      () => PostRepositoryImpl(remoteDataSource: locator()));

  // Casos de uso
  locator.registerFactory(() => GetPost(repository: locator()));
  locator.registerFactory(() => CreatePost(repository: locator()));
  locator.registerFactory(() => UpdatePost(repository: locator()));
  locator.registerFactory(() => DeletePost(repository: locator()));
}
