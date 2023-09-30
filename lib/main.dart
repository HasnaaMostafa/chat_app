import 'package:chat_app/Bloc/login_bloc/login_bloc.dart';
import 'package:chat_app/cubits/Auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/chats_details_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/message_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer= MyBlocObserver();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context)=>AuthCubit()),
        BlocProvider(create: (context)=> ChatCubit()..getUsers()..getMessage()),
        BlocProvider(create: (context)=>LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
       routes: {
          LoginScreen.id : (context)=>LoginScreen(),
          RegisterScreen.id : (context)=>RegisterScreen(),
          MessageScreen.id   : (context)=>MessageScreen(),
          ChatDetailsScreen.id : (context)=>ChatDetailsScreen()


       },
       initialRoute: LoginScreen.id,
      ),
    );
  }
}
