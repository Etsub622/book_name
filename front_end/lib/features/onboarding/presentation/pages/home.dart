import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/common_widget.dart/circular_indicator.dart';
import 'package:front_end/core/common_widget.dart/snack_bar.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/chat/domain/entity/chat_entity.dart';
import 'package:front_end/features/chat/presentation/bloc/bloc/chat_bloc.dart';
import 'package:front_end/features/chat/presentation/pages/chat_room.dart';
import 'package:front_end/features/onboarding/presentation/bloc/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _initiateChat(BuildContext context) async {
    final newUser = ChatInitiate(userId: "66bde36e9bbe07fc39034cdd");

    context.read<ChatBloc>().add(InitiateChatEvent(newUser.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded) {
            final user2 = state.chatRespientResponse.user2;
            final snac = snackBar('Chat created successfully');
            ScaffoldMessenger.of(context).showSnackBar(snac);
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoomScreen(user2: user2),
                ),
              );
            });
          } else if (state is ChatError) {
            final snac = errorsnackBar('Try again');
            ScaffoldMessenger.of(context).showSnackBar(snac);
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const CircularIndicator();
          } else {
            return _build(context);
          }
        },
      ),
    );
  }

  Widget _build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                _showLogoutDialog(context);
              },
              child: const Text('Log Out'),
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
              onPressed: () {
                _initiateChat(context);
              },
              child: const Text('Initiate Chat')),
          SizedBox(height: 20.h),
          ElevatedButton(
              onPressed: () {
                context.go(AppPath.addBooks);
              },
              child: const Text('Add books')),
          SizedBox(height: 20.h),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.go(AppPath.getBooks); 
                },
                child: const Text('All Books'),
              ),
              SizedBox(width: 15.w),
              ElevatedButton(
                onPressed: () {
                  context.go(AppPath.getBooksByCategory,
                      extra: 'comedy'); 
                },
                child: const Text('Comedy'),
              ),
              SizedBox(width: 15.w),
              ElevatedButton(
                onPressed: () {
                  context.go(AppPath.getBooksByCategory,
                      extra: 'fantasy'); 
                },
                child: const Text('Fantasy'),
              ),
              SizedBox(width: 15.w),
              ElevatedButton(
                onPressed: () {
                  context.go(AppPath.getBooksByCategory,
                      extra: 'crime'); 
                },
                child: const Text('Crime'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UserLogoutState) {
              if (state.status == AuthStatus.loaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );

                GoRouter.of(context).go(AppPath.login);
              } else if (state.status == AuthStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            }
          },
          builder: (context, state) {
            return AlertDialog(
              title: const Text('Log Out'),
              content: const Text('Are you sure you want to log out?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogOutEvent());
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
