import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _flowers = [
    {'name': 'Rosas', 'price': '\$25', 'color': Color(0xFFFFD6DE), 'icon': Icons.local_florist},
    {'name': 'Girasoles', 'price': '\$30', 'color': Color(0xFFFFE7A8), 'icon': Icons.wb_sunny},
    {'name': 'Tulipanes', 'price': '\$28', 'color': Color(0xFFFFC7D4), 'icon': Icons.local_florist},
    {'name': 'Orquídeas', 'price': '\$40', 'color': Color(0xFFE4C7F5), 'icon': Icons.spa},
    {'name': 'Lirios', 'price': '\$32', 'color': Color(0xFFFFE4C4), 'icon': Icons.local_florist},
    {'name': 'Margaritas', 'price': '\$22', 'color': Color(0xFFFFF2B8), 'icon': Icons.flare},
    {'name': 'Lavanda', 'price': '\$26', 'color': Color(0xFFDCCCF5), 'icon': Icons.grass},
    {'name': 'Peonías', 'price': '\$36', 'color': Color(0xFFFFC9E1), 'icon': Icons.local_florist},
    {'name': 'Claveles', 'price': '\$24', 'color': Color(0xFFFFD2B8), 'icon': Icons.eco},
    {'name': 'Jazmines', 'price': '\$29', 'color': Color(0xFFE8F2D0), 'icon': Icons.spa},
  ];

  final List<Widget> _pages = const [
    _CatalogPage(),
    _SimplePage(title: 'Favoritos', icon: Icons.favorite_border),
    _SimplePage(title: 'Perfil', icon: Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? _CatalogPage(flowers: _flowers)
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: const Color(0xFFE85D75),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class _CatalogPage extends StatelessWidget {
  const _CatalogPage({this.flowers = const []});

  final List<Map<String, dynamic>> flowers;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFFFD6DE),
                    child: Icon(Icons.person, color: Color(0xFF8C3045)),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, bienvenida',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Encuentra tus flores favoritas',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Catálogo de flores',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _FlowerCard(flower: flowers[index]),
                childCount: flowers.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowerCard extends StatelessWidget {
  const _FlowerCard({required this.flower});

  final Map<String, dynamic> flower;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: flower['color'] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  flower['icon'] as IconData,
                  size: 58,
                  color: const Color(0xFF8C3045),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              flower['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              flower['price'] as String,
              style: const TextStyle(color: Color(0xFFE85D75)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimplePage extends StatelessWidget {
  const _SimplePage({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 72, color: const Color(0xFFE85D75)),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
