import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';



class DonutsPage extends StatefulWidget {
  const DonutsPage({super.key});

  @override
  State<DonutsPage> createState() => _DonutsPageState();
}

class _DonutsPageState extends State<DonutsPage> {
  int _selectedIndex = 0; // Índice da aba selecionada
  final List<CartItem> cart = []; // Lista de itens do carrinho

  // Lista de donuts (produtos)
  final List<Donut> donuts = const [
    Donut(
      'Chocolatte',
      'Delicioso donut coberto com chocolate',
      'https://www.riosoftice.com.br/wp-content/uploads/2020/07/Donuts-Rig-de-Chocolate-Melhor-Bocado.jpg',
      5.00,
    ),
    Donut(
      'Tradicional',
      'Clássico donut açucarado',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSErZV17ykhwNzNizZqk_Emlu5fIuubQonbpQ&s',
      4.50,
    ),
    Donut(
      'White Chocolate',
      'Donut com cobertura de chocolate branco',
      'https://media.istockphoto.com/id/518346482/pt/foto/d%C3%B3nute-com-chocolate-branco-verniz-isolado-num-fundo-branco.jpg?s=612x612&w=0&k=20&c=e-NSecOgXrk-8cQQffF1f2NUZV7sS67eOENrq4_MI7A=',
      5.50,
    ),
    Donut(
      'Mint',
      'Cobertura de menta com gotas de chocolate',
      'https://png.pngtree.com/element_our/20190528/ourlarge/pngtree-a-blueberry-flavored-donut-image_1120470.jpg',
      5.50,
    ),
    Donut(
      'Blueberry',
      'Coberto com glacê de blueberry',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYko3Rv5ziaV89vfbUU9P6nK6utYkaZGjYPA&s',
      5.00,
    ),
  ];

  // Função que retorna a tela correspondente à aba selecionada
  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return BeemilkMenuDonuts(donuts: donuts, onFavorite: _addToCart); 
      case 1:
        return const PlaceholderWidget('Cakes'); 
      case 2:
        return const PlaceholderWidget('Cookies'); 
      case 3:
        return const PlaceholderWidget('Milkshakes'); 
      default:
        return const BeemilkMenuDonuts(donuts: [], onFavorite: null);
    }
  }

  // Função para adicionar ao carrinho
  void _addToCart(Donut donut, int quantity) {
    setState(() {
      cart.add(CartItem(donut, quantity)); // Adiciona o donut ao carrinho com a quantidade selecionada
    });
  }

  // Função para mostrar o carrinho
  void _showCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(cart[index].donut.name),
              subtitle: Text('Quantidade: ${cart[index].quantity}'),
              trailing: Text('\$${(cart[index].donut.price * cart[index].quantity).toStringAsFixed(2)}'),
            );
          },
        );
      },
    );
  }

  // Função para alterar a aba selecionada
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true, // Necessário para o DevicePreview funcionar corretamente
      locale: DevicePreview.locale(context), // Suporte a diferentes locais
      builder: DevicePreview.appBuilder, // Configura o preview
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(onPressed: (){
            Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
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
                    _showCart(context); 
                  },
                ),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        cart.length.toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: _getSelectedPage(), 
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.donut_large), label: 'Donuts'),
        //     BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Cakes'),
        //     BottomNavigationBarItem(icon: Icon(Icons.cookie), label: 'Cookies'),
        //     BottomNavigationBarItem(icon: Icon(Icons.local_drink), label: 'Milkshakes'),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: const Color.fromARGB(255, 254, 254, 3),
        //   onTap: _onItemTapped, 
        // ),
      ),
    );
  }
}

class BeemilkMenuDonuts extends StatelessWidget {
  final List<Donut> donuts;
  final Function(Donut, int)? onFavorite;

  const BeemilkMenuDonuts({super.key, required this.donuts, this.onFavorite});

  // Diálogo para escolher quantidade
  Future<void> _showQuantityDialog(BuildContext context, Donut donut) async {
    int quantity = 1;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Selecione a quantidade de ${donut.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Quantidade:'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Adicionar ao Carrinho'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onFavorite != null) {
                      onFavorite!(donut, quantity); // Adiciona ao carrinho com a quantidade
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Fundo preto
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: donuts.length,
        itemBuilder: (context, index) {
          return DonutCard(
            donut: donuts[index],
            onFavorite: onFavorite, // Chama a função ao clicar no coração
            onQuantityPressed: () {
              _showQuantityDialog(context, donuts[index]); // Mostra o diálogo de quantidade
            },
          );
        },
      ),
    );
  }
}

class Donut {
  final String name;
  final String description;
  final String image;
  final double price;

  const Donut(this.name, this.description, this.image, this.price);
}

class DonutCard extends StatelessWidget {
  final Donut donut;
  final Function(Donut, int)? onFavorite;
  final VoidCallback onQuantityPressed;

  const DonutCard({
    super.key,
    required this.donut,
    this.onFavorite,
    required this.onQuantityPressed,
  });

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
              donut.image,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donut.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(donut.description),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                     
                      ElevatedButton(
                        onPressed: onQuantityPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 240, 252, 7), // Cor do botão
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
                  '\$${donut.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    if (onFavorite != null) {
                      onFavorite!(donut, 1);
                    }
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

// Classe para armazenar itens do carrinho
class CartItem {
  final Donut donut;
  final int quantity;

  CartItem(this.donut, this.quantity);
}

// Placeholder para outras telas
class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
