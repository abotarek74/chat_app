import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoadind());
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
}
