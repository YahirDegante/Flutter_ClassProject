import 'package:learning_2_10c/kernel/utils/dio_client.dart';
import 'package:learning_2_10c/modules/posts/entities/post_entity.dart';
import 'package:learning_2_10c/modules/posts/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<PostEntity> getPost(int id);
  Future<PostEntity> createPost(PostModel model);
  Future<PostEntity> updatePost(PostModel model);
  Future<PostEntity> deletePost(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dioClient;

  PostRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<PostEntity> getPost(int id) async {
    try {
      final response = await dioClient.dio.get('/posts/$id');
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<PostEntity> createPost(PostModel model) async {
    try {
      final response = await dioClient.dio.post('/posts', data: model.toJson());
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create post');
    }
  }

  @override
  Future<PostEntity> updatePost(PostModel model) async {
    try {
      final response =
          await dioClient.dio.put('/posts/${model.id}', data: model.toJson());
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update post');
    }
  }

  @override
  Future<PostEntity> deletePost(int id) async {
    try {
      final response = await dioClient.dio.delete('/posts/$id');
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to delete post');
    }
  }
}
