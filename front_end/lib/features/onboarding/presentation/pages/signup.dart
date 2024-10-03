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

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp(BuildContext context) async {
    final newUser = SignUPModel(
        id: '',
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);

    context.read<AuthBloc>().add(SingUpEvent(signUpEntity: newUser));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          final snack = snackBar('User created successfully');
          ScaffoldMessenger.of(context).showSnackBar(snack);

          Future.delayed(const Duration(seconds: 2), () {
            context.go(AppPath.login);
          });
        } else if (state is AuthErrorState) {
          final snack = errorsnackBar('Sign up failed, try again');
          ScaffoldMessenger.of(context).showSnackBar(snack);
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const CircularIndicator();
        } else {
          return _buildForm(context);
        }
      },
    ));
  }

  Widget _buildForm(BuildContext context) {
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
                'Sign Up',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: (Color(0xff800080))),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomFormField(
                controller: _nameController,
                text: 'Full Name',
              ),
              SizedBox(
                height: 15.h,
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
                height: 15.h,
              ),
              CustomFormField(
                controller: _confirmPasswordController,
                text: 'Confirm Password',
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomButton(
                  wdth: double.infinity,
                  text: 'Sign Up',
                  onTap: () {
                    _signUp(context);
                  }),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () => context.go(AppPath.login),
                    child: Text(
                      'Log In',
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
