import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (context) => const BeemilkApp(),
//     ),
//   );
// }

// class BeemilkApp extends StatelessWidget {
//   const BeemilkApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // ignore: deprecated_member_use
//       useInheritedMediaQuery: true,
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.yellow,
//         scaffoldBackgroundColor: const Color(0xFFFFF8E1),
//       ),
//       home: const HomePage(),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
            Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: const Text('Beemilk App'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 248, 6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bem-vindo e imagem
            const Text(
              "Bem-vindo ao Beemilk!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/017/197/458/non_2x/bee-icon-symbol-silhouette-of-a-honey-bee-sign-on-transparent-background-free-png.png',
              height: 100,
            ),
            const SizedBox(height: 20),

            // Botões de navegação para categorias
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildCategoryCard(
                    context,
                    'Milkshakes',
                    'https://images.vexels.com/media/users/3/264252/isolated/preview/2eae8f71e01f3e656c5b26ebae02b864-copo-de-ilustraa-a-o-de-milk-shake.png',
                    '/milkshake',
                  ),
                  _buildCategoryCard(
                    context,
                    'Donuts',
                    'https://static.vecteezy.com/system/resources/previews/009/380/161/original/delicious-doughnut-set-clipart-design-illustration-free-png.png',
                    '/donuts',
                  ),
                  _buildCategoryCard(
                    context,
                    'Cookies',
                    'https://static.vecteezy.com/system/resources/previews/025/253/702/original/pink-sugar-cookie-png.png',
                    '/cookies',
                  ),
                  _buildCategoryCard(
                    context,
                    'Cakes',
                    'https://static.vecteezy.com/system/resources/previews/015/738/492/non_2x/cute-cartoon-birthday-cake-slice-icon-free-png.png',
                    '/cake',
                  ),
                ],
              ),
            ),

            // Botão do Carrinho
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Ir para a tela do carrinho
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Ver Carrinho"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 237, 233, 10),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para os cards de categorias
  Widget _buildCategoryCard(BuildContext context, String title, String imageUrl, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, height: 80),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
