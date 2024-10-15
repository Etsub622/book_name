import 'package:bloc/bloc.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:meta/meta.dart';
part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {

  List <BookEntity> favoriteBooks = []; 

  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) {});
    on<AddFavoriteEvent> (_onAddFavoriteBook);
    on<RemoveFavoriteEvent> (_onRemoveFavoriteBook);
    on<LoadFavoritesEvent> (_onLoadFavorites);
  }
void _onAddFavoriteBook(AddFavoriteEvent event,Emitter<FavoritesState>emit){
  if (!favoriteBooks.contains(event.book)){
    favoriteBooks.add(event.book);
    emit(FavoriteLoad(favoriteBooks));
  }
}
void _onRemoveFavoriteBook(RemoveFavoriteEvent event, Emitter<FavoritesState>emit){
  if(favoriteBooks.contains(event.book)){
    favoriteBooks.remove(event.book);
    emit(FavoriteLoad(favoriteBooks));
  }
}
void _onLoadFavorites(LoadFavoritesEvent event,Emitter<FavoritesState>emit){
  emit(FavoriteLoad(favoriteBooks));
}

}
