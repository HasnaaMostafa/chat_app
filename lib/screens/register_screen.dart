import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubits/Auth_cubit/auth_cubit.dart';
import '../cubits/chat_cubit/chat_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  static String id = "RegisterScreen";
  String? email;
  String? password;
  String? userName;
  String? phone;

  bool? isPassword;

  bool isLoading = false;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          BlocProvider.of<ChatCubit>(context).getUsers();

          Navigator.pop(context);

          isLoading = false;
        } else if (state is RegisterErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircularProgressIndicator(
            color: Color(0xffE65100),
          ),
          child: Form(
            key: formKey,
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color(0xffE65100),
                        Color(0xffEF6C00),
                        Color(0xffffA726),
                      ],
                      begin: Alignment.topCenter,
                    )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    225, 95, 27, .3),
                                                blurRadius: 20,
                                                offset: Offset(0, 10))
                                          ]),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 0,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: TextFormField(
                                              onFieldSubmitted: (vlaue) {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  BlocProvider.of<AuthCubit>(
                                                          context)
                                                      .registerUser(
                                                          email: email!,
                                                          password: password!,
                                                          phone: phone!,
                                                          userName: userName!);
                                                }
                                              },
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "      User Name must not be empty";
                                                }
                                                return null;
                                              },
                                              onChanged: (String? data) {
                                                userName = data;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "User Name",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  border: InputBorder.none,
                                                  prefixIcon:
                                                      Icon(Icons.person)),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 0,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey.shade300))),
                                            child: TextFormField(
                                              onFieldSubmitted: (value) {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  BlocProvider.of<AuthCubit>(
                                                          context)
                                                      .registerUser(
                                                          email: email!,
                                                          password: password!,
                                                          phone: phone!,
                                                          userName: userName!);
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "      email must not be empty";
                                                }
                                                return null;
                                              },
                                              onChanged: (String? data) {
                                                email = data;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Email",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  border: InputBorder.none,
                                                  prefixIcon:
                                                      Icon(Icons.email)),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 0,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey.shade300))),
                                            child: TextFormField(
                                              onFieldSubmitted: (value) {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  BlocProvider.of<AuthCubit>(
                                                          context)
                                                      .registerUser(
                                                          email: email!,
                                                          password: password!,
                                                          phone: phone!,
                                                          userName: userName!);
                                                }
                                              },
                                              keyboardType: TextInputType.phone,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "      phone must not be empty";
                                                }
                                                return null;
                                              },
                                              onChanged: (String? data) {
                                                phone = data;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Phone number",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  border: InputBorder.none,
                                                  prefixIcon:
                                                      Icon(Icons.phone)),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 0,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: TextFormField(
                                              onFieldSubmitted: (value) {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  BlocProvider.of<AuthCubit>(
                                                          context)
                                                      .registerUser(
                                                          email: email!,
                                                          password: password!,
                                                          phone: phone!,
                                                          userName: userName!);
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: state
                                                      is ChangePasswordVisibilityStates
                                                  ? isPassword = BlocProvider
                                                          .of<AuthCubit>(
                                                              context)
                                                      .isPassword
                                                  : isPassword = BlocProvider
                                                          .of<AuthCubit>(
                                                              context)
                                                      .isPassword,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "      Password must not be empty";
                                                }
                                                return null;
                                              },
                                              onChanged: (String? data) {
                                                password = data;
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  border: InputBorder.none,
                                                  prefixIcon:
                                                      const Icon(Icons.lock),
                                                  suffixIcon: IconButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    AuthCubit>(
                                                                context)
                                                            .changePasswordVisibility();
                                                      },
                                                      icon: Icon(BlocProvider
                                                              .of<AuthCubit>(
                                                                  context)
                                                          .suffix))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<AuthCubit>(context)
                                              .registerUser(
                                                  email: email!,
                                                  password: password!,
                                                  phone: phone!,
                                                  userName: userName!);
                                          print(email);
                                        }
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: const Color(0xffE65100),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Already have an account?"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Login",
                                              style: TextStyle(
                                                color: Color(0xffE65100),
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
