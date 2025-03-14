import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundDecorationTwo extends StatelessWidget {
  const BackgroundDecorationTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(-3, -1.5),
          child: Container(
            height: 276,
            width: 263,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.deepPurple),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1, -2.1),
          child: Container(
            height: 265,
            width: 200,
            decoration: const BoxDecoration(color: Color(0xFFEC7D0F)),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}

class BackgroundDecorationThree extends StatelessWidget {
  const BackgroundDecorationThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(3, -1.5),
          child: Container(
            height: 276,
            width: 263,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.deepPurple),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(1, -2.1),
          child: Container(
            height: 265,
            width: 200,
            decoration: const BoxDecoration(color: Color(0xFFEC7D0F)),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}

class BackgroundDecorationFour extends StatelessWidget {
  const BackgroundDecorationFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(1, -0.7),
          child: Container(
            height: 276,
            width: 263,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.deepPurple),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1, -0.7),
          child: Container(
            height: 276,
            width: 263,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.deepPurple),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, -1.3),
          child: Container(
            height: 265,
            width: 324,
            decoration: const BoxDecoration(color: Color(0xFFEC7D0F)),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}