import 'package:learning_2_10c/modules/posts/entities/post_entity.dart';
import 'package:learning_2_10c/modules/posts/repositories/post_repository.dart';

class UpdatePost {
  final PostRepository repository;

  UpdatePost({required this.repository});

  Future<void> execute(PostEntity post) async {
    await repository.updatePost(post);
  }
}