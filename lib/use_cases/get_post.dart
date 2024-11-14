import 'package:learning_2_10c/modules/posts/entities/post_entity.dart';
import 'package:learning_2_10c/modules/posts/repositories/post_repository.dart';

class GetPost {
  final PostRepository repository;

  GetPost({required this.repository});

  Future<PostEntity> call(int id) async {
    return await repository.getPost(id);
  }
}