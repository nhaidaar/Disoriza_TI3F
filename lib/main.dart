import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import 'core/common/colors.dart';
import 'core/utils/snackbar.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';
import 'features/auth/presentation/pages/auth_page.dart';
// import 'features/home/presentation/pages/home_onboarding.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/home/presentation/pages/splash_screen.dart';
import 'features/komunitas/data/repositories/komunitas_repository_impl.dart';
import 'features/komunitas/domain/usecases/komunitas_usecase.dart';
import 'features/komunitas/presentation/blocs/komunitas_comment/komunitas_comment_bloc.dart';
import 'features/komunitas/presentation/blocs/komunitas_post/komunitas_post_bloc.dart';
import 'features/komunitas/presentation/blocs/komunitas_report/komunitas_report_bloc.dart';
import 'features/komunitas/presentation/blocs/komunitas_search/komunitas_search_bloc.dart';
import 'features/riwayat/data/repositories/riwayat_repository_impl.dart';
import 'features/riwayat/domain/usecases/riwayat_usecase.dart';
import 'features/riwayat/presentation/blocs/riwayat_history/riwayat_history_bloc.dart';
import 'features/riwayat/presentation/blocs/riwayat_scan/riwayat_scan_bloc.dart';
import 'features/setelan/presentation/blocs/setelan_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  final supabase = await supa.Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    debug: true,
  );

  runApp(Disoriza(client: supabase.client));
}

class Disoriza extends StatelessWidget {
  final supa.SupabaseClient client;
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
            create: (context) => AuthBloc(AuthUsecase(AuthRepositoryImpl(client: client)))..add(AuthCheckSession()),
          ),
          BlocProvider(
            create: (context) => KomunitasPostBloc(KomunitasUsecase(KomunitasRepositoryImpl(client: client))),
          ),
          BlocProvider(
            create: (context) => KomunitasCommentBloc(KomunitasUsecase(KomunitasRepositoryImpl(client: client))),
          ),
          BlocProvider(
            create: (context) => KomunitasSearchBloc(KomunitasUsecase(KomunitasRepositoryImpl(client: client))),
          ),
          BlocProvider(
            create: (context) => KomunitasReportBloc(KomunitasUsecase(KomunitasRepositoryImpl(client: client))),
          ),
          BlocProvider(
            create: (context) => RiwayatHistoryBloc(RiwayatUsecase(RiwayatRepositoryImpl(client: client))),
          ),
          BlocProvider(
            create: (context) => RiwayatScanBloc(RiwayatUsecase(RiwayatRepositoryImpl(client: client))),
          ),
          BlocProvider(
            create: (context) => SetelanBloc(AuthUsecase(AuthRepositoryImpl(client: client))),
          ),
        ],
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) showSnackbar(context, message: state.message, isError: true);
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              return const SplashScreen();
            } else if (state is Authenticated) {
              return HomeScreen(
                client: client,
                user: state.user,
              );
            }
            return const AuthPage();
          },
        ),
      ),
    );
  }
}
