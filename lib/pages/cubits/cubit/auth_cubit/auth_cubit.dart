import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFaliure(errorMessage: 'user not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFaliure(errorMessage: 'worng password'));
      }
    } on Exception catch (e) {
      emit(LoginFaliure(errorMessage: 'something went worng'));
    }
  }

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak passoword') {
        emit(RegisterFaliuer(errorMessage: 'weak passoword'));
      } else if (ex.code == 'email is already in use') {
        emit(RegisterFaliuer(errorMessage: 'email is already in use'));
      }
    } on Exception catch (e) {
      emit(RegisterFaliuer(errorMessage: 'there was an error'));
    }
  }
}
