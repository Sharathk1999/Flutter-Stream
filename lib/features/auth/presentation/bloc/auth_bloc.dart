import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_stream/core/common/entities/user.dart';
import 'package:flutter_stream/core/usecase/usecase.dart';
import 'package:flutter_stream/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_stream/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_stream/features/auth/domain/usecases/user_logout.dart';
import 'package:flutter_stream/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //_userSignUp not accessible outside
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final UserLogout _userLogout;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserLogout userLogout,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _userLogout = userLogout,
        super(AuthInitial()) {
    on<AuthEvent>(
      (_, emit) => emit(
        AuthLoading(),
      ),
    );
    on<AuthSignUpEvent>(_onAuthSignUp);

    on<AuthLoginEvent>(_onAuthLogin);

    on<AuthIsUserLoggedInEvent>(_isUserLoggedIn);
    on<AuthLogoutEvent>(_onAuthLogout);
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParameters(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _onAuthLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
  final res = await _userLogout(NoParams());

  res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthInitial(),),);
  
}

}
