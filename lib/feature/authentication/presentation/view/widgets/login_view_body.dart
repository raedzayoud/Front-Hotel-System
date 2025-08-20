import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hotel/core/utils/function/snackbar.dart';
import 'package:hotel/feature/authentication/presentation/manager/cubit/authentication_cubit.dart';
import 'package:hotel/feature/authentication/presentation/view/widgets/content_body_login.dart';
import 'package:hotel/feature/home/presentation/manager/home_cubit.dart';
import 'package:hotel/main.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    //String? errorMessage;

    return SafeArea(
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            snackbarerror(context, state.errorMessage);
          } else if (state is LoginSuccess) {
            sharedPreferences.setString("token", state.token);
            tokenSharedPreferences.setString("token", state.token);
            BlocProvider.of<HomeCubit>(context).getProfile();
            Navigator.of(context)
                .pushNamedAndRemoveUntil("Homescrrenview", (route) => false);
          }
        },
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child: content_body_login(
                    formKey: formKey,
                    username: username,
                    password: password,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
