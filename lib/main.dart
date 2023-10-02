import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_management/presentation/bloc/google_login/google_login_bloc.dart';
import 'package:waste_management/presentation/bloc/login/login_bloc.dart';
import 'package:waste_management/presentation/bloc/logout/logout_bloc.dart';
import 'package:waste_management/presentation/bloc/signup/signup_bloc.dart';
import 'package:waste_management/presentation/screens/authentication/splash_screen.dart';
import 'package:waste_management/presentation/screens/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRoute _appRoute = AppRoute();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => GoogleLoginBloc()),
        BlocProvider(create: (context) => LogoutBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: _appRoute.onGenerateRoute,
        home: SplashScreen(),
      ),
    );
  }
}



// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_management/infrastucture/authentication/google_signin.dart';
// import 'package:waste_management/presentation/screens/authentication/splash_screen.dart';
// import 'package:waste_management/presentation/screens/router/app_router.dart';


// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp( MyApp());
// }

// class MyApp extends StatelessWidget {
//    MyApp({super.key});
// final AppRoute _appRoute = AppRoute();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => GoogleSignInFlutter(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(  
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         onGenerateRoute: _appRoute.onGenerateRoute,
//         home:  SplashScreen(),
//       ),
//     );
//   }
// }

