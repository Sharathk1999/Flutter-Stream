import 'dart:io';

import 'package:flutter_stream/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImplementation implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImplementation(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from("blogs").insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from("blog_images").upload(blog.id, image);

      return supabaseClient.storage.from("blog_images").getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
  
  @override
  Future<List<BlogModel>> getAllBlogs()async {
   try {
    //blogs table have poster_id is foreign key to profiles table (join-SQL)
    final blogs = await supabaseClient.from('blogs').select('*, profiles (name)');
    return blogs.map((blog) =>BlogModel.fromJson(blog).copyWith(
      posterName: blog['profiles']['name'],
    )).toList();
   } catch (e) {
     throw ServerException(message: e.toString());
   }
  }
}
