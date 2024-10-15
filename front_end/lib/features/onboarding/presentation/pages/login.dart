import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/common_widget.dart/circular_indicator.dart';
import 'package:front_end/core/common_widget.dart/snack_bar.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/onboarding/data/models/auth_model.dart';
import 'package:front_end/features/onboarding/presentation/bloc/bloc/auth_bloc.dart';
import 'package:front_end/features/onboarding/presentation/widget/button.dart';
import 'package:front_end/features/onboarding/presentation/widget/form_field.dart';
import 'package:go_router/go_router.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _logIn(BuildContext context) async {
    final newUser = LogInModel(
        id: '',
        email: _emailController.text,
        password: _passwordController.text);

    context.read<AuthBloc>().add(LogInEvent(logInEntity: newUser));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            final snac = snackBar('User logged in successfully');
            ScaffoldMessenger.of(context).showSnackBar(snac);
            Future.delayed(const Duration(seconds: 2), () {
              context.go(AppPath.navbar);
            });
          } else if (state is AuthErrorState) {
            final snac = errorsnackBar('Log in failed, try again');
            ScaffoldMessenger.of(context).showSnackBar(snac);
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const CircularIndicator();
          } else {
            return _build(context);
          }
        },
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () => context.go(AppPath.welcome),
                  child: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    size: 26.sp,
                    color: (Color(0xff800080)),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Log In',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: (Color(0xff800080))),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomFormField(
                controller: _emailController,
                text: 'Email',
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomFormField(
                controller: _passwordController,
                text: 'Password',
              ),
              SizedBox(
                height: 45.h,
              ),
              CustomButton(
                  wdth: double.infinity,
                  text: 'LogIn',
                  onTap: () {
                    _logIn(context);
                  }),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () => context.go(AppPath.signup),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: (Color(0xff800080)),
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
