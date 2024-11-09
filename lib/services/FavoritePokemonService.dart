import 'package:shared_preferences/shared_preferences.dart';

class FavoritePokemonService {

  late SharedPreferences _prefs;

  List<String> _favoritePokemonList = [];

  Future<List<String>> get getFavoritePokemonList async {
    _prefs = await SharedPreferences.getInstance();
    _favoritePokemonList = _prefs.getStringList('favoritePokemonList') ?? [];
    return _favoritePokemonList;

  }

  Future<void> addToFavorites(String pokemonName) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _favoritePokemonList = _prefs.getStringList('favoritePokemonList') ?? [];

      if (_favoritePokemonList.contains(pokemonName)) {
        _favoritePokemonList.remove(pokemonName);
        await _prefs.setStringList('favoritePokemonList', _favoritePokemonList);

      } else {
        _favoritePokemonList.add(pokemonName);
        await _prefs.setStringList('favoritePokemonList', _favoritePokemonList);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> checkIsFavorite(String pokemonName) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _favoritePokemonList = _prefs.getStringList('favoritePokemonList') ?? [];

      return _favoritePokemonList.contains(pokemonName);

    } catch (e) {
      throw Exception(e);
    }
  }
}
