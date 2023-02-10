import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plant_shop_app/src/models/plants_model.dart';
import 'package:flutter_plant_shop_app/src/pages/details/plant_details.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    super.initState();
  }

  _plantSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlantScreen(
                plant: plants[index],
              ),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF32A060),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
              child: Stack(
                children: [
                  //Image
                  Center(
                    child: Hero(
                      tag: plants[index].imageUrl,
                      child: Image(
                        image: AssetImage(plants[index].imageUrl),
                        height: 280.0,
                        width: 280.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //Price Section
                  Positioned(
                    top: 30.0,
                    right: 30.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'FROM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          '\$${plants[index].price}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Category and Name
                  Positioned(
                    left: 30.0,
                    bottom: 40.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plants[index].category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          plants[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Cart Bottom
            Positioned(
              bottom: 4.0,
              child: RawMaterialButton(
                padding: const EdgeInsets.all(15.0),
                shape: const CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.black,
                child: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          children: [
            //Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.menu,
                    size: 30.0,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.shopping_cart,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Top Picks
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                'Top Picks',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            //tabs
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.withOpacity(0.6),
              labelPadding: const EdgeInsets.symmetric(horizontal: 35.0),
              isScrollable: true,
              tabs: const [
                Tab(
                  child: Text(
                    'Top',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Outdoor',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Indoor',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'New Arrivals',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Limited Edition',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            //Content PageView
            SizedBox(
              height: 500.0,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                itemCount: plants.length,
                itemBuilder: (context, index) {
                  return _plantSelector(index);
                },
              ),
            ),
            //Descriptions
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    plants[_selectedPage].description,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
