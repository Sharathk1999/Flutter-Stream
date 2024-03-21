part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogFailureState extends BlogState {
  final String error;

  BlogFailureState(this.error);
}

final class BlogUploadSuccessState extends BlogState {}

final class BlogDisplaySuccessState extends BlogState {
  final List<Blog> blogs;

  BlogDisplaySuccessState(this.blogs);
}
