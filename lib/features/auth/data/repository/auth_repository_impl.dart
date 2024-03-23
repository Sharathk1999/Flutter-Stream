// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_stream/core/common/entities/user.dart';
import 'package:flutter_stream/core/error/exceptions.dart';
import 'package:flutter_stream/core/error/failures.dart';
import 'package:flutter_stream/core/network/connection_checker.dart';
import 'package:flutter_stream/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_stream/features/auth/data/models/user_model.dart';
import 'package:flutter_stream/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  //for DI
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('User is not logged in!'));
        }
        return right(
          UserModel(
            id: session.user.id,
            name: '',
            email: session.user.email ?? "",
          ),
        );
      }
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
      if (!await connectionChecker.isConnected) {
        return left(Failure("No Internet connection"));
      }
      final user = await fn();

      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
