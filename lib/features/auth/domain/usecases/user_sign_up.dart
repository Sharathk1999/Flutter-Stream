// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_stream/core/common/entities/user.dart';
import 'package:flutter_stream/core/error/failures.dart';
import 'package:flutter_stream/core/usecase/usecase.dart';
import 'package:flutter_stream/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParameters> {
  //for DI
  final AuthRepository authRepo;
  const UserSignUp(this.authRepo);
  
  @override
  Future<Either<Failure, User>> call(UserSignUpParameters params) async {
    return await authRepo.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParameters {
  final String name;
  final String email;
  final String password;
  UserSignUpParameters({
    required this.name,
    required this.email,
    required this.password,
  });
}
