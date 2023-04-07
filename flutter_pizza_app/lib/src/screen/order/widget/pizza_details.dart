import 'package:flutter/material.dart';
import 'package:flutter_pizza_app/src/model/ingredient_model.dart';
import 'package:flutter_pizza_app/src/utils/constants.dart';

class PizzaDetails extends StatefulWidget {
  const PizzaDetails({super.key});

  @override
  State<PizzaDetails> createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails>
    with SingleTickerProviderStateMixin {
  final _listIngredient = <Ingredient>[];
  late AnimationController _animationController;
  int total = 700;
  final _notifierFocused = ValueNotifier(false);
  final List<Animation> _animationList = <Animation>[];
  late BoxConstraints _pizzaConstraints;

  void _buildIngredientAnimation() {
    _animationList.clear();
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.7, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.decelerate),
      ),
    );
  }

  Widget _buildIngredientWidget() {
    List<Widget> elements = [];
    if (_animationList.isNotEmpty) {
      for (int i = 0; i < _listIngredient.length; i++) {
        Ingredient ingredient = _listIngredient[i];
        for (int j = 0; j < ingredient.positions.length; j++) {
          final animation = _animationList[j];
          final position = ingredient.positions[j];
          final positionX = position.dx;
          final positionY = position.dy;

          if (i == _listIngredient.length - 1) {
            double fromX = 0.0, fromY = 0.0;
            if (j < 1) {
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = -_pizzaConstraints.maxHeight * (1 - animation.value);
            } else {
              fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
            }

            final opacity = animation.value;

            if (animation.value > 0) {
              elements.add(
                Opacity(
                  opacity: opacity,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..translate(
                        fromX + _pizzaConstraints.maxWidth * positionX,
                        fromY + _pizzaConstraints.maxHeight * positionY,
                      ),
                    child: Image.asset(
                      ingredient.image,
                      height: 40,
                    ),
                  ),
                ),
              );
            }
          } else {
            elements.add(
              Transform(
                transform: Matrix4.identity()
                  ..translate(
                    _pizzaConstraints.maxWidth * positionX,
                    _pizzaConstraints.maxHeight * positionY,
                  ),
                child: Image.asset(
                  ingredient.image,
                  height: 40,
                ),
              ),
            );
          }
        }
      }
      return Stack(
        children: elements,
      );
    }
    return SizedBox.fromSize();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: DragTarget<Ingredient>(
                onAccept: (ingredient) {
                  _notifierFocused.value = false;
                  setState(() {
                    _listIngredient.add(ingredient);
                    total = total + 50;
                  });
                  _buildIngredientAnimation();
                  _animationController.forward(from: 0.0);
                  print('accept');
                },
                onWillAccept: (ingredient) {
                  _notifierFocused.value = true;
                  print('onWillaccept');
                  for (Ingredient i in _listIngredient) {
                    if (i.compare(ingredient!)) {
                      return false;
                    }
                  }

                  return true;
                },
                onLeave: (ingredient) {
                  _notifierFocused.value = false;
                  print('onLeaveaccept');
                },
                builder: (context, candidateData, rejectedData) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      _pizzaConstraints = constraints;
                      return ValueListenableBuilder<Object>(
                        valueListenable: _notifierFocused,
                        builder: (context, focused, _) {
                          return AnimatedContainer(
                            height: constraints.maxHeight,

                            /*focused
                                ? constraints.maxHeight
                                : constraints.maxHeight - 20,*/
                            duration: const Duration(milliseconds: 400),
                            child: Stack(
                              children: [
                                Image.asset('$path/dish.png'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('$path/pizza-1.png'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: const Offset(0.0, 0.0),
                        end: Offset(0.0, animation.value),
                      ),
                    ),
                    child: child,
                  ),
                );
              },
              child: Text(
                '\$$total',
                key: UniqueKey(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return _buildIngredientWidget();
          },
        )
      ],
    );
  }
}
