const Order = Parse.Object.extend('Order');
const OrderItem = Parse.Object.extend('OrderItem');
const CartItem = Parse.Object.extend('CartItem');

const product = require('./product');

//Realizar CheckOut
Parse.Cloud.define('checkout', async(request)=>{
	if(request.user == null) throw 'Invalid User';
	const queryCartItem = new Parse.Query(CartItem);
	queryCartItem.equalTo('user',request.user);
	queryCartItem.include('product');
	const resultCartItem = await queryCartItem.find({useMasterKey:true});

	let total=0;
	for(let item of resultCartItem){
		item = item.toJSON();
		total += item.quantity * item.product.price;
	}
	if(request.params.total!= total) throw 'Invalid_total';
	//Salvando Pedido
	const order = new Order();
	order.set('total',total);
	order.set('user',request.user);
	const savedOrder = await order.save(null,{useMasterKey:true});

	//salvar detalhes do pedido na tabela OrderItem
	for(let item of resultCartItem){
		const orderItem = new OrderItem();
		orderItem.set('order',savedOrder);
		orderItem.set('user',request.user);
		orderItem.set('product',item.get('product'));
		orderItem.set('quantity',item.get('quantity'));
		orderItem.set('price',item.toJSON().product.price);
		await orderItem.save(null,{useMasterKey:true});
	}

	//remover item do carrinho apos realizar o pedido
	await Parse.Object.destroyAll(resultCartItem,{useMasterKey:true});
	
	return{
		id:savedOrder.id
	}
});

//Get Order
Parse.Cloud.define('get-order', async(request)=>{
	if(request.user == null) throw 'Invalid User';
	const queryOrders = new Parse.Query(Order);
	queryOrders.equalTo('user',request.user);
	const resultOrder = await queryOrders.find({useMasterKey:true});
	return resultOrder.map(function (o){
		o = o.toJSON();
		return{
			id: o.objectId,
			total: o.total,
			createdAt: o.createdAt,
		}

	});
});

//Get Order Items
Parse.Cloud.define('get-order-items', async(request)=>{
	if(request.user == null) throw 'Invalid User';
	if(request.params.orderId==null) throw 'Invalid order';

	const order = new Order();
	order.id = request.params.orderId;

	const queryOrderItems = new Parse.Query(OrderItem);
	queryOrderItems.equalTo('order',order);
	queryOrderItems.equalTo('user',request.user);
	queryOrderItems.include('product');
	queryOrderItems.include('product.category');

	const resultOrderItems = await queryOrderItems.find({useMasterKey:true});
	return resultOrderItems.map(function (o){
		o = o.toJSON();
		return{
			id: o.objectId,
			quantity: o.quantity,
			price:o.price,
			product: product.formatProduct(o.product),
		}

	});
});