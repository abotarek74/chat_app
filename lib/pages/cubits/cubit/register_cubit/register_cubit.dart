import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

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
