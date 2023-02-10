const Product = Parse.Object.extend('Product');
const CartItem = Parse.Object.extend('CartItem');

const product = require('./product');

//Adicionar item no carrinho de compra
Parse.Cloud.define('add-item-to-cart',async (request)=>{
	if(request.user == null) throw 'Invalid User';
	if(request.params.quantity==null) throw 'Invalid Qantity';
	if(request.params.productId==null) throw 'Invalid Product';
	const cartItem = new CartItem();
	cartItem.set('quantity', request.params.quantity);

	const product = new Product();
	product.id = request.params.productId;

	cartItem.set('product',product);
	cartItem.set('user',request.user);

	const savedItem = await cartItem.save(null, {useMasterKey:true});
	return{
		id: savedItem.id
	}
});

//Modificar item no carrinho
Parse.Cloud.define('modify-item-quantity',async (request)=>{
	const cartItemId = request.params.cartItemId;
	const quantity = request.params.quantity;

	if(cartItemId==null) throw 'Invalid Cart item';
	if(quantity==null) throw 'Invalid Quantity';

	const cartItem = new CartItem();
	cartItem.id = cartItemId;
	
	if(quantity>0){
		cartItem.set('quantity', quantity);
	await cartItem.save(null, {useMasterKey:true});
	}else{
		await cartItem.destroy({useMasterKey:true});
	}
	
});

//Listar carrinho
Parse.Cloud.define('get-cart-item',async (request)=>{
	if(request.user == null) throw 'Invalid User';
	const queryCartItem = new Parse.Query(CartItem);

	//Condison
	queryCartItem.equalTo('user',request.user);
	queryCartItem.include('product');
	queryCartItem.include('product.category');
	const resultCartItem = await queryCartItem.find({useMasterKey:true});
	return resultCartItem.map(function(c){
		c = c.toJSON();
		return {
			id: c.objectId,
			quantity: c.quantity,
			product: product.formatProduct(c.product),
		}
	});
});