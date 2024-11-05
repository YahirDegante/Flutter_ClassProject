import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learning_2_10c/modules/home/entities/restaurant.dart';
import 'package:learning_2_10c/widgets/home/list_restaurant_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Restaurant> restaurants = [];
  final db = FirebaseFirestore.instance;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    db.collection("restaurants").snapshots().listen((event) {
      restaurants = [];
      for (var doc in event.docs) {
        final restaurant = Restaurant(
          doc.data()['name'],
          doc.data()['description'],
          doc.data()['imagenes'],
          doc.data()['rating'],
          doc.data()['count'],
          doc.data()['direction'],
        );
        restaurants.add(restaurant);
      }
      if (mounted) {
        setState(() => isLoading = false);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pushNamed(context, '/top'),
        },
        child: const Icon(Icons.chevron_right),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          return ListRestaurantData(restaurant: restaurants[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
