import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is loginEvent) {
        emit(LoginLoadingState());
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.password)
            .then((value) {
          emit(LoginSuccessState());
        }).catchError((error) {
          if (error is FirebaseAuthException) {
            if (error.code == 'wrong-password') {
              emit(LoginErrorState(error: "wrong-password"));
            } else if (error.code == 'user-not-found') {
              emit(LoginErrorState(error: "user-not-found"));
            }
          } else {
            emit(LoginErrorState(error: "something went wrong"));
            print(error.toString());
          }
          emit(LoginErrorState(error: "invalid email!"));
        });
      }
    });
  }
}
