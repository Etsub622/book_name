import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/core/injection/injection.dart'as di;
import 'package:front_end/features/book/presentation/bloc/bloc/book_bloc.dart';
import 'package:front_end/features/chat/presentation/bloc/bloc/chat_bloc.dart';
import 'package:front_end/features/favorites/presntation/bloc/favorites_bloc.dart';

import 'package:front_end/features/onboarding/presentation/bloc/bloc/auth_bloc.dart';

class BlocMultiProvider {
  List<BlocProvider<dynamic>> blocMultiProvider() {
    return [
      BlocProvider<AuthBloc>(
        create: (context) => di.sl<AuthBloc>()),

        BlocProvider<BookBloc>(
        create: (context) => di.sl<BookBloc>()),

         BlocProvider<ChatBloc>(
        create: (context) => di.sl<ChatBloc>()),

         BlocProvider<FavoritesBloc>(
        create: (context) => di.sl<FavoritesBloc>()),
    ];
  }
}
