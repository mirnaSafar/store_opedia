import 'package:bloc/bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState(isFavorite: false));

  void addToFavorites() => emit(FavoriteState(isFavorite: true));
  void removeFromFavorites() => emit(FavoriteState(isFavorite: false));
}
