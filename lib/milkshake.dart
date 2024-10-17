import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto/cookies.dart';
import 'package:flutter_projeto/donuts.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true, // Ative o DevicePreview
//       builder: (context) => const MilkshakeApp(), // Chame o app de milkshakes
//     ),
//   );
// }

class MilkshakePage extends StatefulWidget {
  const MilkshakePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MilkshakePageState createState() => _MilkshakePageState();
}

class _MilkshakePageState extends State<MilkshakePage> {
  int _selectedIndex = 0; // Para o controle de navegação no menu inferior

  // Função para mudar a tela quando uma opção do menu é selecionada
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  
  final List<Widget> _screens = [
    const BeemilkMenuMilkshakes(),
    const DonutsPage(), 
    const CookiesPage(), 
    const MilkshakePage(), 
  ];

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
                    // Tela de carrinho (pode ser implementada no futuro)
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
                        '${_totalItemsInCart()}', // Total de itens no carrinho
                        style: const TextStyle(
                          color: Colors.white,
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
        body: _screens[_selectedIndex], // Carrega a tela de acordo com a seleção
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.local_drink),
        //       label: 'Milkshakes',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.donut_large),
        //       label: 'Donuts',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.cookie),
        //       label: 'Cookies',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.cake),
        //       label: 'Cakes',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: const Color.fromARGB(255, 255, 244, 28),
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }
}

// Função para calcular o total de itens no carrinho
int _totalItemsInCart() {
  int total = 0;
  for (var item in cart) {
    total += item['quantity'] as int;
  }
  return total;
}

// Carrinho global (lista de itens e quantidade)
List<Map<String, dynamic>> cart = [];

class BeemilkMenuMilkshakes extends StatelessWidget {
  const BeemilkMenuMilkshakes({super.key});

  final List<Milkshake> milkshakes = const [
    Milkshake(
      'Chocolate com Café',
      'Milkshake de chocolate com café',
      'https://informebrasil.com.br/wp-content/uploads/2020/10/Milk-shake-435-1.jpg',
      12.50,
    ),
    Milkshake(
      'Doce de Leite',
      'Milkshake de doce de leite',
      'https://4.bp.blogspot.com/-AfAElzrKKNg/Thsy9tKh5gI/AAAAAAAAAC8/Pg2oetBLBX0/s1600/387384_8955.jpg',
      13.00,
    ),
    Milkshake(
      'Baunilha com Café',
      'Milkshake de baunilha com café',
      'https://thumbs.dreamstime.com/b/vidro-do-milk-shake-da-baunilha-67049861.jpg',
      11.50,
    ),
    Milkshake(
      'Blueberry',
      'Milkshake de blueberry',
      'https://thumbs.dreamstime.com/b/blueberry-milkshake-whipped-cream-98459768.jpg',
      14.00,
    ),
    Milkshake(
      'Frutas Vermelhas',
      'Milkshake de frutas vermelhas',
      'https://thumbs.dreamstime.com/b/milkshake-de-morango-com-xarope-decorado-fruta-batida-ideal-para-restaurante-e-bares-181116827.jpg',
      13.50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Fundo preto
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: milkshakes.length,
        itemBuilder: (context, index) {
          return MilkshakeCard(milkshake: milkshakes[index]);
        },
      ),
    );
  }
}

class Milkshake {
  final String name;
  final String description;
  final String image;
  final double price;

  const Milkshake(this.name, this.description, this.image, this.price);
}

class MilkshakeCard extends StatefulWidget {
  final Milkshake milkshake;

  const MilkshakeCard({super.key, required this.milkshake});

  @override
  // ignore: library_private_types_in_public_api
  _MilkshakeCardState createState() => _MilkshakeCardState();
}

class _MilkshakeCardState extends State<MilkshakeCard> {
  int quantity = 1;

  // Função para adicionar ao carrinho com a quantidade escolhida
  void _addToCart() {
    setState(() {
      var item = cart.firstWhere(
          (element) => element['milkshake'] == widget.milkshake,
          orElse: () => {});
      if (item.isNotEmpty) {
        item['quantity'] += quantity; // Adiciona a quantidade ao existente
      } else {
        cart.add({'milkshake': widget.milkshake, 'quantity': quantity});
      }
    });
  }

  // Função para mostrar o diálogo de quantidade com "+" e "-"
  void _showQuantityDialog(BuildContext context) {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        int tempQuantity = quantity;
        return AlertDialog(
          title: const Text("Escolha a quantidade"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      if (tempQuantity > 1) {
                        setState(() {
                          tempQuantity--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$tempQuantity'),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        tempQuantity++;
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  quantity = tempQuantity;
                });
                Navigator.of(context).pop(tempQuantity);
              },
              child: const Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }

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
              widget.milkshake.image,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.milkshake.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.milkshake.description),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _showQuantityDialog(context),
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
                  '\$${widget.milkshake.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: _addToCart,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

