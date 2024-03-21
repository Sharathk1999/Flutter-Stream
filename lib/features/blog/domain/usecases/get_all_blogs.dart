import 'package:flutter_stream/core/error/failures.dart';
import 'package:flutter_stream/core/usecase/usecase.dart';
import 'package:flutter_stream/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params)async {
    return await blogRepository.getAllBlogs();
  }
  
}