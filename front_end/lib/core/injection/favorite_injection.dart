import 'package:front_end/core/injection/injection.dart';
import 'package:front_end/features/chat/presentation/bloc/bloc/chat_bloc.dart';
import 'package:front_end/features/favorites/presntation/bloc/favorites_bloc.dart';

class FavoriteInjection {
  init() {
    // Bloc
    sl.registerFactory<FavoritesBloc>(() => FavoritesBloc());
  }
}
