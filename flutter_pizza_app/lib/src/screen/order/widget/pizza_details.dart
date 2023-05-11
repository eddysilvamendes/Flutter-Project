// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_pizza_app/src/model/ingredient_model.dart';
import 'package:flutter_pizza_app/src/screen/order/widget/pizza_size_button.dart';
import 'package:flutter_pizza_app/src/utils/constants.dart';

class PizzaDetails extends StatefulWidget {
  const PizzaDetails({super.key});

  @override
  State<PizzaDetails> createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails>
    with TickerProviderStateMixin {
  final _listIngredient = <Ingredient>[];
  late AnimationController _animationController;
  late AnimationController _animationRotationController;
  int total = 700;
  final _notifierFocused = ValueNotifier(false);
  final List<Animation> _animationList = <Animation>[];
  late BoxConstraints _pizzaConstraints;
  bool isSelect = false;
  final notifierPizzaSize =
      ValueNotifier<_PizzaSizeState>(_PizzaSizeState(_PizzaSizeValue.m));

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
        final ingredientWidgetImage = Image.asset(
          ingredient.imageUnit,
          height: 40,
        );
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
                    child: ingredientWidgetImage,
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
                child: ingredientWidgetImage,
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
    _animationRotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationRotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              //Builder de animason de prato e ingredientes
              return LayoutBuilder(
                builder: (context, constraints) {
                  _pizzaConstraints = constraints;
                  return ValueListenableBuilder<_PizzaSizeState>(
                      valueListenable: notifierPizzaSize,
                      builder: (context, pizzaSize, _) {
                        return RotationTransition(
                          turns: CurvedAnimation(
                              curve: Curves.elasticOut,
                              parent: _animationRotationController),
                          child: Stack(
                            children: [
                              Center(
                                child: ValueListenableBuilder<bool>(
                                  valueListenable: _notifierFocused,
                                  builder: (context, focused, _) {
                                    return AnimatedContainer(
                                      height: constraints.maxHeight *
                                          pizzaSize.factor,

                                      /*focused
                                        ? constraints.maxHeight*
                                          pizzaSize.factor
                                        : constraints.maxHeight - 20, *
                                          pizzaSize.factor*/
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: Stack(
                                        children: [
                                          Image.asset('$path/dish.png'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                '$path/pizza-1.png'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, _) {
                                  return _buildIngredientWidget();
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        //TOTAL Section
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
        //Size Section
        const SizedBox(
          height: 15,
        ),
        ValueListenableBuilder<_PizzaSizeState>(
            valueListenable: notifierPizzaSize,
            builder: (context, pizzaSize, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PizzaSizeButton(
                    isSelected: pizzaSize.value == _PizzaSizeValue.s,
                    text: 'S',
                    onTap: () {
                      _updatePizzaSize(_PizzaSizeValue.s);
                    },
                  ),
                  PizzaSizeButton(
                    isSelected: pizzaSize.value == _PizzaSizeValue.m,
                    text: 'M',
                    onTap: () {
                      _updatePizzaSize(_PizzaSizeValue.m);
                    },
                  ),
                  PizzaSizeButton(
                    isSelected: pizzaSize.value == _PizzaSizeValue.l,
                    text: 'L',
                    onTap: () {
                      _updatePizzaSize(_PizzaSizeValue.l);
                    },
                  ),
                ],
              );
            }),
      ],
    );
  }

  void _updatePizzaSize(_PizzaSizeValue value) {
    notifierPizzaSize.value = _PizzaSizeState(value);
    _animationRotationController.forward(from: 0.0);
  }
}

enum _PizzaSizeValue { s, m, l }

class _PizzaSizeState {
  _PizzaSizeState(this.value) : factor = _getFactorBySize(value);
  final _PizzaSizeValue value;
  final double factor;

  static double _getFactorBySize(_PizzaSizeValue value) {
    switch (value) {
      case _PizzaSizeValue.s:
        return 0.80;
      case _PizzaSizeValue.m:
        return 0.90;
      case _PizzaSizeValue.l:
        return 1.2;
    }
  }
}
