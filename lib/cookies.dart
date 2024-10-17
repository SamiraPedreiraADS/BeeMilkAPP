import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true, // Ative o DevicePreview
//       builder: (context) => const CookieApp(), // Chame o app de cookies
//     ),
//   );
// }

class CookiesPage extends StatefulWidget {
  const CookiesPage({super.key});

  @override
  State<CookiesPage> createState() => _CookiesPageState();
}

class _CookiesPageState extends State<CookiesPage> {
  int _selectedIndex = 0; // Índice da aba selecionada
  final List<CartItem> cart = []; // Lista de itens do carrinho

  // Lista de cookies (produtos)
  final List<Cookie> cookies = const [
    Cookie(
      'Tradicional',
      'Clássico cookie tradicional',
      'https://www.riosoftice.com.br/wp-content/uploads/2017/03/cookies-tradicionais-2.jpg',
      8.50,
    ),
    Cookie(
      'Chocolate Branco com M&M',
      'Cookie recheado com M&M',
      'https://tse2.mm.bing.net/th?id=OIP.g80oMvr3WDqZPKZl-T0lpgAAAA&pid=Api&P=0&h=180',
      9.00,
    ),
    Cookie(
      'Gotas de Chocolate',
      'Cookie de chocolate com gotas',
      'https://www.thegreatcookie.com/cdn/shop/products/great-cookie-04_1024x1024.jpg?v=1389211315',
      9.50,
    ),
    Cookie(
      'Red Velvet',
      'Delicioso cookie red velvet',
      'https://tse3.mm.bing.net/th?id=OIP._SSQn7zAhDS2jsb0B2g4jQHaHE&pid=Api&P=0&h=180',
      10.00,
    ),
    Cookie(
      'Limão Siciliano',
      'Cookie de limão siciliano',
      'https://www.thegreatcookie.com/cdn/shop/products/great-cookie-snickerdoodle-cookie_1024x1024.jpg?v=1386795548',
      9.00,
    ),
  ];

  // Função que retorna a tela correspondente à aba selecionada
  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return BeemilkMenuCookies(cookies: cookies, onFavorite: _addToCart); // Tela de cookies
      case 1:
        return const PlaceholderWidget('Donuts'); // Placeholder para Donuts (você pode personalizar depois)
      case 2:
        return const PlaceholderWidget('Cakes'); // Placeholder para Cakes (você pode personalizar depois)
      case 3:
        return const PlaceholderWidget('Milkshakes'); // Placeholder para Milkshakes (você pode personalizar depois)
      default:
        return const BeemilkMenuCookies(cookies: [], onFavorite: null);
    }
  }

  // Função para adicionar ao carrinho
  void _addToCart(Cookie cookie, int quantity) {
    setState(() {
      cart.add(CartItem(cookie, quantity)); // Adiciona o cookie ao carrinho com a quantidade selecionada
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
              title: Text(cart[index].cookie.name),
              subtitle: Text('Quantidade: ${cart[index].quantity}'),
              trailing: Text('\$${(cart[index].cookie.price * cart[index].quantity).toStringAsFixed(2)}'),
            );
          },
        );
      },
    );
  }

  // Função para alterar a aba selecionada
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Atualiza o índice da aba selecionada
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
                    _showCart(context); // Mostra o carrinho quando clicado
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
        body: _getSelectedPage(), // Chama a página de acordo com a aba selecionada
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.cookie), label: 'Cookies'),
        //     BottomNavigationBarItem(icon: Icon(Icons.donut_large), label: 'Donuts'),
        //     BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Cakes'),
        //     BottomNavigationBarItem(icon: Icon(Icons.local_drink), label: 'Milkshakes'),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: const Color.fromARGB(255, 254, 254, 3),
        //   onTap: _onItemTapped, // Altera a página ao clicar em um item do menu
        // ),
      ),
    );
  }
}

class BeemilkMenuCookies extends StatelessWidget {
  final List<Cookie> cookies;
  final Function(Cookie, int)? onFavorite;

  const BeemilkMenuCookies({super.key, required this.cookies, this.onFavorite});

  // Diálogo para escolher quantidade
  Future<void> _showQuantityDialog(BuildContext context, Cookie cookie) async {
    int quantity = 1;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Selecione a quantidade de ${cookie.name}'),
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
                      onFavorite!(cookie, quantity); // Adiciona ao carrinho com a quantidade
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
        itemCount: cookies.length,
        itemBuilder: (context, index) {
          return CookieCard(
            cookie: cookies[index],
            onFavorite: onFavorite, // Chama a função ao clicar no coração
            onQuantityPressed: () {
              _showQuantityDialog(context, cookies[index]); // Mostra o diálogo de quantidade
            },
          );
        },
      ),
    );
  }
}

class Cookie {
  final String name;
  final String description;
  final String image;
  final double price;

  const Cookie(this.name, this.description, this.image, this.price);
}

class CookieCard extends StatelessWidget {
  final Cookie cookie;
  final Function(Cookie, int)? onFavorite;
  final VoidCallback onQuantityPressed;

  const CookieCard({
    super.key,
    required this.cookie,
    required this.onQuantityPressed,
    this.onFavorite,
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
              cookie.image,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cookie.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(cookie.description),
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
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                if (onFavorite != null) {
                  onFavorite!(cookie, 1); // Adiciona com a quantidade mínima de 1
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final Cookie cookie;
  int quantity;

  CartItem(this.cookie, this.quantity);

  get cake => null;
}

// PlaceholderWidget para outras abas (Donuts, Cakes, Milkshakes)
class PlaceholderWidget extends StatelessWidget {
  final String text;

  const PlaceholderWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}


