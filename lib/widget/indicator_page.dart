import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

 Padding indicatorPage({
  required int selectedIndex
 }) {
    return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: AnimatedSmoothIndicator(
                    activeIndex: selectedIndex,
                    count: 5,
                    effect: const WormEffect(
                        dotColor: Color.fromARGB(255, 250, 234, 187),
                        activeDotColor: Colors.blue),
                  ),
                );
  }