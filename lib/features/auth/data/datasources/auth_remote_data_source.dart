//It will ensure a strict contract to follow and ensure developer don't miss out anything

import 'package:flutter_stream/core/error/exceptions.dart';
import 'package:flutter_stream/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUser();

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // ? not initializing here because DI is better if we want to change the database.
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          "name": name,
        },
      );
      if (response.user == null) {
        throw const ServerException(message: "User is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException(message: "User is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from("profiles")
            .select()
            .eq('id', currentUserSession!.user.id);
            return UserModel.fromJson(userData.first).copyWith(
              email: currentUserSession!.user.email,
            );
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
  
  @override
  Future<void> logout()async {
   try {
     await supabaseClient.auth.signOut();
   } catch (e) {
     throw ServerException(message: e.toString());
   }
  }
}
