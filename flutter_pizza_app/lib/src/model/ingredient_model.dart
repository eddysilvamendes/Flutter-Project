// ignore_for_file: public_member_api_docs, sort_constructors_first
//const String path = 'assets/images';

import 'package:flutter/material.dart';

import 'package:flutter_pizza_app/src/utils/constants.dart';

class Ingredient {
  final String image;
  final List<Offset> positions;
  Ingredient({
    required this.image,
    required this.positions,
  });

  bool compare(Ingredient ingredient) => ingredient.image == image;
}

final ingredients = <Ingredient>[
  Ingredient(
    image: '$path/chili.png',
    positions: <Offset>[
      const Offset(0.2, 0.2),
      const Offset(0.6, 0.2),
      const Offset(0.4, 0.25),
      const Offset(0.5, 0.3),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: '$path/olive.png',
    positions: <Offset>[
      const Offset(0.2, 0.35),
      const Offset(0.65, 0.35),
      const Offset(0.3, 0.23),
      const Offset(0.5, 0.2),
      const Offset(0.3, 0.5),
    ],
  ),
  Ingredient(
    image: '$path/onion.png',
    positions: <Offset>[
      const Offset(0.25, 0.5),
      const Offset(0.65, 0.6),
      const Offset(0.2, 0.3),
      const Offset(0.4, 0.2),
      const Offset(0.2, 0.6),
    ],
  ),
  Ingredient(
    image: '$path/pea.png',
    positions: <Offset>[
      const Offset(0.2, 0.65),
      const Offset(0.65, 0.3),
      const Offset(0.25, 0.25),
      const Offset(0.45, 0.35),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: '$path/pickle.png',
    positions: <Offset>[
      const Offset(0.2, 0.35),
      const Offset(0.65, 0.35),
      const Offset(0.3, 0.23),
      const Offset(0.5, 0.2),
      const Offset(0.3, 0.5),
    ],
  ),
  Ingredient(
    image: '$path/potato.png',
    positions: <Offset>[
      const Offset(0.2, 0.65),
      const Offset(0.65, 0.3),
      const Offset(0.25, 0.25),
      const Offset(0.45, 0.35),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: '$path/mushroom.png',
    positions: <Offset>[
      const Offset(0.2, 0.2),
      const Offset(0.6, 0.2),
      const Offset(0.4, 0.25),
      const Offset(0.5, 0.3),
      const Offset(0.4, 0.65),
    ],
  ),
];
