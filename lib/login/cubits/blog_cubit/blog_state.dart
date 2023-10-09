import '../../../data/models/blog_model.dart';

abstract class BlogState {}

class BlogInitialState extends BlogState {}

class BlogLoadingState extends BlogState {}

class BlogLoadedState extends BlogState {
  final List<Blog> blogs;

  BlogLoadedState({required this.blogs});
}

class BlogErrorState extends BlogState {
  final String error;

  BlogErrorState({required this.error});
}
