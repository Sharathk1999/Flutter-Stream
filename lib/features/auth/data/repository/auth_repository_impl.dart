import 'package:flutter_stream/core/common/entities/user.dart';
import 'package:flutter_stream/core/error/exceptions.dart';
import 'package:flutter_stream/core/error/failures.dart';
import 'package:flutter_stream/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_stream/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  //for DI
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      if (user == null) {
        return left(Failure('User is not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUserFunc(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUserFunc(
        () async => await remoteDataSource.signUpWithEmailPassword(
              name: name,
              email: email,
              password: password,
            ));
  }

  Future<Either<Failure, User>> _getUserFunc(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();

      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
