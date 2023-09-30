import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void loginUser({required String email, required String password}) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
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
    });
  }

  void logoutUser() async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance.signOut().then((value) {
      emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LogoutErrorState(error: error.toString()));
    });
  }

  void registerUser({
    required String email,
    required String password,
    required String userName,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        email: email,
        userName: userName,
        phone: phone,
        uId: value.user!.uid,
      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'weak-password') {
          emit(RegisterErrorState(error: "weak-password"));
        } else if (error.code == 'email-already-in-use') {
          emit(RegisterErrorState(error: "email-already-in-use"));
        }
      } else {
        emit(RegisterErrorState(error: "something went wrong"));
        print(error.toString());
      }
    });
  }

  void userCreate({
    required String email,
    required String userName,
    required String phone,
    required String uId,
  }) async {
    UserModel model = UserModel(
        userName: userName,
        phone: phone,
        email: email,
        uId: uId,
        image:
            "https://writingcenter.fas.harvard.edu/sites/hwpi.harvard.edu/files/styles/os_files_xxlarge/public/writingcenter/files/person-icon.png?m=1614398157&itok=Bvj8bd7F");

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserCreatedSuccessStates());
    }).catchError((error) {
      emit(UserCreatedErrorStates(error.toString()));
    });
  }
}
