import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/common/colors.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/home/presentation/pages/splash_screen.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/usecases/user_usecase.dart';
import 'features/user/presentation/cubit/user_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Appwrite config
  await dotenv.load();
  Client client = Client();
  client
      .setEndpoint(dotenv.get('FLASK_APPWRITE_URL'))
      .setProject(dotenv.get('FLASK_APPWRITE_PROJECT_ID'))
      .setSelfSigned(status: true);

  runApp(Disoriza(client: client));
}

class Disoriza extends StatelessWidget {
  final Client client;
  const Disoriza({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disoriza',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundCanvas,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(AuthUsecase(AuthRepositoryImpl(client: client))),
          ),
          BlocProvider(
            create: (context) => UserCubit(UserUsecase(UserRepositoryImpl(client: client))),
          ),
        ],
        child: BlocProvider(
          create: (context) => BlocProvider.of<AuthCubit>(context)..checkSession(),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthInitial) {
                return const SplashScreen();
              } else if (state is Authenticated) {
                return HomeScreen(user: state.user);
              } else {
                return const AuthPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
