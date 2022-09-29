part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated(this.user);

  @override
  String toString() => 'Authenticated(user: $user)';
}

class UnAuthenticated extends AuthState {
  @override
  String toString() => 'UnAuthenticated';
}

extension AuthStateUnion on AuthState {
  T map<T>({
    required T Function(AuthLoading) loading,
    required T Function(Authenticated) authenticated,
    required T Function(UnAuthenticated) unAuthenticated,
  }) {
    if (this is AuthLoading) {
      return loading(this as AuthLoading);
    }
    if (this is Authenticated) {
      return authenticated(this as Authenticated);
    }
    if (this is UnAuthenticated) {
      return unAuthenticated(this as UnAuthenticated);
    }

    throw AssertionError('Union does not match any possible values');
  }
}
