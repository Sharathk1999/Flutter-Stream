// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(
    this.uploadBlog,
  ) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => BlogLoadingState());
    on<BlogUploadEvent>(_onBlogUploadEvent);
  }

  void _onBlogUploadEvent(
      BlogUploadEvent event, Emitter<BlogState> emit) async {
   final result = await uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));

    result.fold((l) => emit(BlogFailureState(l.message)), (r) => emit(BlogSuccessState()));
  }
}
