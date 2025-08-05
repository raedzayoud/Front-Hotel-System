import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/calendar.dart';
import 'package:hotel/core/utils/router.dart';
import 'package:hotel/feature/authentication/data/repos/authentication_repo_impl.dart';
import 'package:hotel/feature/authentication/presentation/manager/cubit/authentication_cubit.dart';
import 'package:hotel/feature/authentication/presentation/view/login_view.dart';
import 'package:hotel/feature/home/data/repos/home_repos_impl.dart';
import 'package:hotel/feature/home/presentation/home.dart';
import 'package:hotel/feature/home/presentation/homescrren.dart';
import 'package:hotel/feature/home/presentation/manager/home_cubit.dart';
import 'package:hotel/feature/rooms/data/repos/room_repos_impl.dart';
import 'package:hotel/feature/rooms/presentation/manager/room_cubit.dart';
import 'package:hotel/feature/wallet/data/repos/wallet_repos_impl.dart';
import 'package:hotel/feature/wallet/presentation/manager/wallet_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(AuthenticationRepoImpl()),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(HomeReposImpl()),
        ),
        BlocProvider<RoomCubit>(
          create: (context) => RoomCubit(RoomReposImpl()),
        ),
        BlocProvider<WalletCubit>(
          create: (context) => WalletCubit(WalletReposImpl()),
        ),
        // Add other BLoCs here if needed, like AuthBloc, HotelBloc, etc.
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: sharedPreferences.getString("token") == null
            ? LoginView()
            : Homescrrenview(),
        routes: AppRouter.pageRoutes,
      ),
    );
  }
}
