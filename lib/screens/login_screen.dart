import 'package:chat_app/Bloc/login_bloc/login_bloc.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/chats_details_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen  extends StatelessWidget {
  LoginScreen ({super.key});

  static String id ="LoginScreen";

  static String? email;
  String? password;
  bool isLoading= false;
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (context) => ChatCubit(),
       child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // BlocProvider.of<ChatCubit>(context).getUsers();
          // BlocProvider.of<ChatCubit>(context).getUsers();
        if(state is LoginLoadingState){
          isLoading=true;
        }
        else if(state is LoginSuccessState){

          Navigator.pushNamed(
              context,
              ChatDetailsScreen.id ,
              arguments:email);

          // BlocProvider.of<ChatCubit>(context).getUsers(senderEmail: email!);


          isLoading=false;
        }

        else if (state is LoginErrorState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          isLoading=false;
        }
          },
       builder: (context,state){
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircularProgressIndicator(
            color:  Color(0xffE65100),
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
                        )
                    ),
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
                              Text("Login" ,
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 40
                                ),),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Welcome Back" ,
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),),
                            ],
                          ),
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight:Radius.circular(60)),
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
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: const [BoxShadow(
                                              color: Color.fromRGBO(225, 95, 27, .3),
                                              blurRadius: 20,
                                              offset: Offset(0,10)
                                          )]
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding : const EdgeInsets.only(
                                              left: 0,
                                              right: 10,
                                              top: 10,
                                              bottom: 10
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(color: Colors.grey.shade300))
                                            ),
                                            child: TextFormField(
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "please enter your email!";
                                                }
                                                return null;
                                              },
                                              onChanged:(String? data){
                                                email=data;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Email ",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  border: InputBorder.none,
                                                prefixIcon: Icon(Icons.email,)
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding : const EdgeInsets.only(
                                                left: 0,
                                                right: 10,
                                                top: 10,
                                                bottom: 10
                                            ),
                                            child: TextFormField(
                                              obscureText: true,
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "please enter your password !";
                                                }
                                                return null;
                                              },
                                              onChanged:(String? data){
                                                password=data;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Password",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  border: InputBorder.none,
                                                prefixIcon: Icon(Icons.lock)
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        if (formKey.currentState!.validate())
                                        {
                                          // BlocProvider.of<AuthCubit>(context)
                                          //     .loginUser(
                                          //     email: email!,
                                          //     password: password!);
                                          // print(email);

                                          BlocProvider.of<LoginBloc>(context)
                                              .add(loginEvent(
                                              email: email!,
                                              password: password!));
                                      }},
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 50),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: const Color(0xffE65100),
                                          ),
                                          child: const Center(
                                            child: Text("Login",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                          )
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("Don't have an account?"),
                                        const SizedBox(width: 5,),
                                        TextButton(onPressed: (){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (BuildContext context)=> RegisterScreen()));
                                        },
                                            child: const Text("Register now",
                                              style:TextStyle(
                                                color: Color(0xffE65100),
                                                fontSize: 10
                                              ) ,))
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

),
);
  }
}

