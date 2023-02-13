import 'package:merceariaonline/src/models/cart_item_model.dart';
import 'package:merceariaonline/src/models/item_model.dart';
import 'package:merceariaonline/src/models/user_model.dart';

//Dados Mock, Dados fixos

ItemModel apple = ItemModel(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imgUrl: 'assets/image/fruits/apple.png',
  itemName: 'Maçã',
  price: 90,
  unit: 'kg',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/image/fruits/grape.png',
  itemName: 'Uva',
  price: 110,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/image/fruits/guava.png',
  itemName: 'Goiaba',
  price: 120,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/image/fruits/kiwi.png',
  itemName: 'Kiwi',
  price: 80,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/image/fruits/mango.png',
  itemName: 'Manga',
  price: 40,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/image/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 70,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

//Lista de categoria
List<String> categories = [
  'Frutas',
  'Legumes',
  'Verduras',
  'Cereais',
  'Temperos',
  'Bebidas',
  'Higienico',
  'Limpeza',
];

//Lista de carrinho
List<CartItemModel> cartitem = [
  CartItemModel(item: apple, quantity: 2, id: '1'),
  CartItemModel(item: mango, quantity: 1, id: '1'),
  CartItemModel(item: guava, quantity: 4, id: '1'),
];

//User
UserModel user = UserModel(
  email: "eddysilvamendes19@gmail.com",
  cpf: '123.456.789-10',
  nome: 'Eddy Mendes',
  password: '',
  phone: '5999889',
);
