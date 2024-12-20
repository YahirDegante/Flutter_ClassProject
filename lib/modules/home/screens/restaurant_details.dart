import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:learning_2_10c/modules/home/entities/restaurant.dart';
import 'package:learning_2_10c/widgets/home/restaurant_map.dart';

class RestaurantDetails extends StatefulWidget {
  final Restaurant? restaurant;

  const RestaurantDetails({super.key, this.restaurant});

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < widget.restaurant!.imagenes.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant!.name),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: PageView(
                controller: _pageController,
                children: widget.restaurant!.imagenes.map((url) {
                  return Image.network(
                    url,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  widget.restaurant!.name,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                StarRating(
                  rating: widget.restaurant!.rating,
                )
              ],
            ),
            const SizedBox(height: 8.0),
            Text(widget.restaurant!.description),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 8.0),
            Expanded(
              child: RestaurantMap(
                latitude: widget.restaurant!.latitude,
                longitude: widget.restaurant!.longitude,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
