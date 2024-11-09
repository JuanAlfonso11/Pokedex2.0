import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/pages/PokemonListFiltro.dart';
import 'package:pokedex_poyectfinal/services/FavoritePokemonService.dart';
import 'package:pokedex_poyectfinal/services/PokemonProvider.dart';
import 'package:pokedex_poyectfinal/services/PokemonService.dart';
import 'package:provider/provider.dart';

class ItemFiltro extends StatefulWidget {
  final IconData icono;
  final String texto;

  const ItemFiltro({
    Key? key,
    required this.icono,
    required this.texto,
  }) : super(key: key);

  @override
  _ItemFiltroState createState() => _ItemFiltroState();
}

class _ItemFiltroState extends State<ItemFiltro> {
  late Set<String> selectedTypes;
  // late List<String> tipos = getPokemonTypes() as List<String>;

  @override
  void initState() {
    super.initState();
    selectedTypes = Set<String>();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<TypeSelected>(builder: (context, filterNotifier, child) {
      return InkWell(
        child: ListTile(
          leading: Icon(widget.icono),
          title: Text(widget.texto),
          onTap: () async {
            switch (widget.texto) {
              case "Filtrado por Tipo":
                final pokemonTypes = await getPokemonTypes();
                ModalTypesSelect(context, pokemonTypes, filterNotifier);
                break;

              case "Filtrado por generacion":

                final generaciones = await getPokemonGenerations();

                // ignore: use_build_context_synchronously
                ModalGenerationSelect(context, generaciones);
                break;

              case "Inicio":
              // Volvemos a la pantalla principal (la primera en la pila de navegación)
                Navigator.popUntil(context, (route) => route.isFirst);
                break;

              case "Favoritos":
                FavoritePokemonService favService = FavoritePokemonService();

                final pokemones = await favService.getFavoritePokemonList;
                print(pokemones);
                // ignore: use_build_context_synchronously
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PokemonListFiltro(pokemonNames: pokemones))
                );
                break;

              default:
              // Manejar caso no definido, si es necesario.
            }
          },

        ),
      );
    });
  }

  Future<dynamic> ModalGenerationSelect(BuildContext context, List<String> generaciones) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selecciona la generación',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded( // Añadido Expanded para permitir que el ListView ocupe el espacio restante
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: generaciones.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        final pokemones = await getPokemonsNameByGeneration(generaciones[index]);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => PokemonListFiltro(pokemonNames: pokemones))
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.shade700,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          generaciones[index],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Future<dynamic> ModalTypesSelect(BuildContext context,
      List<String> pokemonTypes, TypeSelected filterNotifier) {

    // List<String> hola = await getPokemonTypes();
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Selecciona los tipos de pokemones',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        final tipos = Provider.of<TypeSelected>(context, listen: false).selectedTypes;
                        final pokemonNamesByTipe = await getPokemonNamesByTypes(tipos.first, tipos.last);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PokemonListFiltro(
                                pokemonNames: pokemonNamesByTipe),
                          ),
                        );

                        // print(test.length);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Color de fondo del botón
                      ),
                      child: const Text(
                        "Aplicar",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                  ),
                  itemCount: 18,
                  itemBuilder: (BuildContext context, int index) {
                    final type = pokemonTypes[index];
                    bool isSelected =
                    filterNotifier.selectedTypes.contains(type);

                    return TypeGridItem(
                      type: type,
                      isSelected: isSelected,
                      onSelected: (value) {
                        filterNotifier.toggleType(type);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TypeGridItem extends StatefulWidget {
  final String type;
  late bool isSelected;
  final Function(bool) onSelected;

  TypeGridItem({
    Key? key,
    required this.type,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  _TypeGridItemState createState() => _TypeGridItemState();
}

class _TypeGridItemState extends State<TypeGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
          widget.onSelected(widget.isSelected);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: sombreado(context, widget.type),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(
          'assets/icon_types/${widget.type}.png',
          width: 15.0,
          height: 15.0,
        ),
      ),
    );
  }
}

Color? sombreado (context, type) {
  final providerSelected = Provider.of<TypeSelected>(context).selectedTypes;
  if (providerSelected.length == 2 && !providerSelected.contains(type)) {
    return null;
  } else if(providerSelected.length <= 2 && providerSelected.contains(type)) {
    return Colors.grey.withOpacity(0.5);
  }

}