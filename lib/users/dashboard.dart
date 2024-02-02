// ignore_for_file: must_be_immutable

import 'package:ecom/gtex/dashboardGetx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});
  Dashboards dashboard = Get.put(Dashboards());

  @override
  Widget build(BuildContext context) {
    // print(dashboard.productList);
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: dashboard.productList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print('Hello');
                  },
                  child: Card(
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                  'https://retailminded.com/wp-content/uploads/2016/03/EN_GreenOlive-1.jpg',
                                  fit: BoxFit.cover,
                                  width: 200),
                            ),
                            Text(
                              dashboard.productList[index]['name'],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Price'),
                                Text(
                                  dashboard.productList[index]['price'],
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                );
              }),
        ));
  }
}
