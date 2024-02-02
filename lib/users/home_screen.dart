import 'package:ecom/users/dashboard.dart';
import 'package:ecom/users/order.dart';
import 'package:ecom/users/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  final String? token;
  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String email;
  final _index = 0.obs;
  final _title = "Dashboard".obs;
  @override
  void initState() {
    //  implement initState
    super.initState();
    Map<String, dynamic> jwtDecoder = JwtDecoder.decode(widget.token!);
    email = jwtDecoder['email'];
  }

  List<Widget> screen = [DashBoard(), const Profile(), const Order()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[300],
        title: Obx(() => Center(child: Text(_title.value))),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: Obx(() => SafeArea(child: screen[_index.value])),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: _index.value,
            onTap: (value) {
              _index.value = value;
              switch (_index.value) {
                case 0:
                  {
                    _title.value = 'Dashboard';
                  }
                  break;
                case 1:
                  {
                    _title.value = 'Profile';
                  }
                  break;
                case 2:
                  {
                    _title.value = 'Order';
                  }
                  break;
              }
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.blue[400],
            unselectedItemColor: Colors.grey[350],
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart_sharp), label: 'Order'),
            ],
          )),
    );
  }
}
