import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/widgets/ItemFiltro.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.red, // Fondo rojo
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/pokedex.png', // Reemplaza con la ruta de tu imagen
                    width: 150, // Ajusta el ancho de la imagen según tus necesidades
                    height: 150, // Ajusta la altura de la imagen según tus necesidades
                  ),
                ),
              ],
            ),
          ),
          const ItemFiltro(icono: Icons.home, texto: "Inicio"),
          const ItemFiltro(icono: Icons.cached_sharp, texto: 'Filtrado por Tipo'),
          const ItemFiltro(icono: Icons.punch_clock_rounded, texto: 'Filtrado por generacion'),
          const ItemFiltro(icono: Icons.star, texto: 'Favoritos'),

        ],
      ),
    );
  }
}

