import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/constant.dart';
import 'package:hotel/core/utils/assets.dart';
import 'package:hotel/core/utils/function/snackbar.dart';
import 'package:hotel/core/utils/function/validator.dart';
import 'package:hotel/feature/authentication/presentation/view/widgets/custom_button.dart';
import 'package:hotel/feature/authentication/presentation/view/widgets/custom_image.dart';
import 'package:hotel/feature/authentication/presentation/view/widgets/custom_password_forget.dart';
import 'package:hotel/feature/authentication/presentation/view/widgets/custom_text_field.dart';
import 'package:hotel/feature/authentication/presentation/view/widgets/custom_title.dart';
import 'package:hotel/feature/authentication/presentation/view/widgets/have_account.dart';
import 'package:hotel/feature/authentication/presentation/view/widgets/signup.dart';

class content_body_register extends StatelessWidget {
  const content_body_register({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
    required this.confirmPassword,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController email;
  final TextEditingController username;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final TextEditingController phone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(
                  url: AssetsImage.hotel,
                ),
                const CustomTitle(
                  title: "Welcome to Your Hotel",
                  subtitle: "Find and reserve the perfect room",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const SizedBox(height: 10),
                CustomTextField(
                  obscureText: false,
                  validator: (val) {
                    return validateEmail(val);
                  },
                  controller: email,
                  hintText: "Enter your email",
                  suffixIcon: Icon(Icons.email,color: KPrimayColor,),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  obscureText: false,
                  validator: (val) {
                    return validateFullName(val);
                  },
                  controller: username,
                  hintText: "Enter your username",
                  suffixIcon: Icon(Icons.person,color: KPrimayColor,),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  obscureText: false,
                  validator: (val) {
                    return validatePhone(val);
                  },
                  controller: phone,
                  hintText: "Enter your phone",
                  suffixIcon: Icon(Icons.phone,color: KPrimayColor,),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  obscureText: true,
                  validator: (val) {
                    return validatePassword(val);
                  },
                  controller: password,
                  hintText: "Enter your password",
                  suffixIcon: Icon(Icons.lock,color: KPrimayColor,),
                ),
                SizedBox(height: 30),
                CustomTextField(
                  obscureText: true,
                  validator: (val) {
                    return validatePassword(val);
                  },
                  controller: confirmPassword,
                  hintText: "Confirm your password",
                  suffixIcon: Icon(Icons.lock,color: KPrimayColor,),
                ),
                SizedBox(height: 30),
                CustomButton(
                    text: "Register",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //   if(password.text!=confirmPassword.text){
                        //     snackbarerror(context, "The password and the confirm password are not equal !");
                        //     return ;
                        //   }
                        //   User user = User(
                        //       email: email.text,
                        //       username: username.text,
                        //       phone: phone.text,
                        //       password: password.text,
                        //       password_confirmation: confirmPassword.text);

                        //   BlocProvider.of<AuthenticationCubit>(context)
                        //       .signIn(user);
                        // }
                      }
                    }),
                SizedBox(
                  height: 5,
                ),
                Have_Account(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
