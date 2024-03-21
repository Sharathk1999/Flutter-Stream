// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream/core/usecase/usecase.dart';
import 'package:flutter_stream/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_stream/features/blog/domain/usecases/upload_blog.dart';

import '../../domain/entities/blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => BlogLoadingState());
    on<BlogUploadEvent>(_onBlogUploadEvent);
    on<BlogGetAllEvent>(_onBlogLoadEvent);
  }

  void _onBlogUploadEvent(
      BlogUploadEvent event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));

    result.fold((l) => emit(BlogFailureState(l.message)),
        (r) => emit(BlogUploadSuccessState()));
  }

  void _onBlogLoadEvent(BlogGetAllEvent event, Emitter<BlogState> emit) async {
    final result = await _getAllBlogs(NoParams());
    result.fold(
      (l) => emit(
        BlogFailureState(l.message),
      ),
      (r) => emit(
        BlogDisplaySuccessState(
          r,
        ),
      ),
    );
  }
}
