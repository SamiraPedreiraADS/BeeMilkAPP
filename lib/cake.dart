import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true, // Ative o DevicePreview
//       builder: (context) => const BeemilkApp(), // Chame o app principal
//     ),
//   );
// }

// class BeemilkApp extends StatelessWidget {
//   const BeemilkApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // ignore: deprecated_member_use
//       useInheritedMediaQuery: true, // Necessário para o DevicePreview funcionar corretamente
//       locale: DevicePreview.locale(context), // Suporte a diferentes locais
//       builder: DevicePreview.appBuilder, // Configura o preview
//       debugShowCheckedModeBanner: false,
//       home: const BeemilkHome(), // Tela principal com o menu inferior
//     );
//   }
// }

class CakesPage extends StatefulWidget {
  const CakesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CakesPageState createState() => _CakesPageState();
}

class _CakesPageState extends State<CakesPage> {
  List<Cake> cart = [];
  int _currentIndex = 0;

  void addToCart(Cake cake) {
    setState(() {
      cart.add(cake);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      BeemilkMenu(addToCart: addToCart),
      const Center(child: Text("Cookies")), // Implementação futura
      const Center(child: Text("Donuts")),  // Implementação futura
      const Center(child: Text("Milkshakes")), // Implementação futura
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 244, 28),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/017/197/458/non_2x/bee-icon-symbol-silhouette-of-a-honey-bee-sign-on-transparent-background-free-png.png', // URL da imagem da abelha
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text('BEEMILK'),
          ],
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(cart: cart),
                    ),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 226, 249, 22),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
      body: screens[_currentIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.cake),
      //       label: 'Cakes', 
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.cookie),
      //       label: 'Cookies',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.donut_large),
      //       label: 'Donuts',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.local_drink),
      //       label: 'Milkshakes',
      //     ),
      //   ],
      // ),
    );
  }
}

class BeemilkMenu extends StatelessWidget {
  final Function(Cake) addToCart;

  const BeemilkMenu({super.key, required this.addToCart});

  final List<Cake> cakes = const [
    Cake(
      'Chocolate',
      'Bolo de Chocolate com cobertura de brigadeiro',
      'https://tse2.mm.bing.net/th?id=OIP.GF2tdh12ZqTP6wVZ1Qi_pwHaHa&pid=Api&P=0&h=180',
      15.00,
    ),
    Cake(
      'Morango',
      'Bolo de morango com chantilly e pedaços de morango',
      'https://receitatodahora.com.br/wp-content/uploads/2022/03/bolo-de-morango-com-chantilly-scaled.jpg',
      15.00,
    ),
    Cake(
      'Laranja com Limão',
      'Bolo de laranja com cobertura de limão',
      'https://1.bp.blogspot.com/-f9R-8ARZwbE/XearoJ_rT9I/AAAAAAAAEIg/ctV0RMC6bMkXhd_gSUTz-zv0FgVY7eLTgCLcBGAsYHQ/s1600/Bolo+de+laranja.jpg',
      15.00,
    ),
    Cake(
      'Leite Ninho',
      'O verdadeiro bolo de leite ninho, cremoso e irresistível',
      'https://tse3.mm.bing.net/th?id=OIP.lJqgU6tgfwEUEm9lhf0p3QHaE8&pid=Api&P=0&h=180',
      16.00,
    ),
    Cake(
      'KitKat com M&M',
      'Bolo de chocolate coberto com KitKat e M&M',
      'http://2.bp.blogspot.com/-107ft-Y-8Tw/VgliiMM6oHI/AAAAAAAAgag/jMYcwHk_5u8/s1600/bolo-kit-kat-dois-andares.jpg',
      25.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cakes.length,
        itemBuilder: (context, index) {
          return CakeCard(
            cake: cakes[index],
            addToCart: addToCart,
          );
        },
      ),
    );
  }
}

class Cake {
  final String name;
  final String description;
  final String image;
  final double price;

  const Cake(this.name, this.description, this.image, this.price);
}

class CakeCard extends StatelessWidget {
  final Cake cake;
  final Function(Cake) addToCart;

  const CakeCard({super.key, required this.cake, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              cake.image,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cake.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(cake.description),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          addToCart(cake);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 240, 252, 7),
                        ),
                        child: const Text("Quantidade"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'R\$ ${cake.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    addToCart(cake);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Cake> cart;

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cake = cart[index];
          return ListTile(
            leading: Image.network(cake.image, width: 50, height: 50),
            title: Text(cake.name),
            subtitle: Text('R\$ ${cake.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
