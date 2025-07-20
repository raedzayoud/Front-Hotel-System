import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/core/utils/function/snackbar.dart';
import 'package:hotel/core/utils/function/successsnackbar.dart';
import 'package:hotel/feature/authentication/presentation/manager/cubit/authentication_cubit.dart';
import 'package:hotel/feature/authentication/presentation/view/widgets/content_body_register.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController solde = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? errorMessage;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    age.dispose();
    solde.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          snackbarerror(context, state.errorMessage);
        } else if (state is AuthenticationSuccess) {
          snackbarsuccess(context, "user created succesfully");
          Navigator.of(context)
              .pushNamedAndRemoveUntil("login", (route) => false);
        }
      },
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: content_body_register(
                  formKey: _formKey,
                  email: email,
                  username: username,
                  password: password,
                  age: age,
                  solde: solde,
                  confirmPassword: confirmPassword,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
