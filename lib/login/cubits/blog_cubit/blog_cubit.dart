import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace_internshala_projecr/data/repositories/blog_repository.dart';
import '../../../data/models/blog_model.dart';
import 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitialState());

  BlogRepository blogRepository = BlogRepository();

  void fetchBlogs() async {
    emit(BlogLoadingState());
    try {
      List<Blog> blogs = await blogRepository.fetchPosts();
      emit(BlogLoadedState(blogs: blogs));
    } catch (e) {
      emit(BlogErrorState(error: 'Error: $e'));
    }
  }
}
