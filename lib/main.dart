import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/core/utils/router.dart';
import 'package:hotel/feature/authentication/data/repos/authentication_repo_impl.dart';
import 'package:hotel/feature/authentication/presentation/manager/cubit/authentication_cubit.dart';
import 'package:hotel/feature/authentication/presentation/view/login_view.dart';

void main() {
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
        // Add other BLoCs here if needed, like AuthBloc, HotelBloc, etc.
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginView(),
        routes: AppRouter.pageRoutes,
      ),
    );
  }
}
