import 'package:learning_2_10c/modules/posts/entities/post_entity.dart';
import 'package:learning_2_10c/modules/posts/repositories/post_repository.dart';

class DeletePost {
  final PostRepository repository;
  DeletePost({required this.repository});

  Future<PostEntity> call(int postId) async {
    return repository.deletePost(postId);
  }
}
