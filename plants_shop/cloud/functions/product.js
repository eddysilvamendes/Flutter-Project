const Product = Parse.Object.extend('Product');
const Category = Parse.Object.extend('Category');

//Format Product
function formatProduct(productJson){
	return {
		id: productJson.objectId,
		title: productJson.title,
		description: productJson.description,
		price: productJson.price,
		unit: productJson.unit,
		picture: productJson.picture!=null ? productJson.picture.url : null,
		stock:productJson.stock,
		isActive: productJson.isSelling,
		category: {
			title:productJson.category.title,
			id:productJson.category.objectId,
		}
	}
}
module.exports ={formatProduct}


Parse.Cloud.define("create_product",async (request)=>{
	//if(request.user== null)throw "Need Authentication";
	  const stock = request.params.stock;
	  if(stock==null || stock > 999) throw "Invalid quantity";
	  if(request.params.categoryId == null) throw "Invalid category";
	
	  //connect uma Category a um product
	  const category = new Category();
	  category.id = request.params.categoryId;
	
	  const product = new Product();
	  product.set("title",request.params.title);
	 // product.set("picture",request.params.picture);
	  product.set("unit",request.params.unit);
	  product.set("price",request.params.price);
	  product.set("description",request.params.description);
	  product.set("stock",request.params.stock);
	  product.set("isSelling",request.params.isActive);
	  
	 
	  product.set("category",category);
	  const savedProduct = await product.save(null,{useMasterKey:true});
	 return savedProduct.id;
	});

// Listar produtos
Parse.Cloud.define('get-product-list', async(request) => {
	const queryProducts = new Parse.Query(Product);
	//Condison da query
	const itemPerPage = request.params.itemPerPage || 20;
	if(itemPerPage > 100) throw 'Quantidade de item por pagina invalida!';

	//Busca por titulo
	if(request.params.title !=null){
		queryProducts.fullText('title',request.params.title);
		//queryProducts.matches('title','.*' +request.params.title + '.*');
	}

	//Busca por categoria
	if(request.params.categoryId!=null){
		const category = new Category();
		category.id = request.params.categoryId;

		queryProducts.equalTo('category', category);
	}

	queryProducts.skip(itemPerPage * request.params.page || 0);
	queryProducts.limit(itemPerPage);
	queryProducts.include('category')

	const resultProducts = await queryProducts.find({useMasterKey: true});

	return resultProducts.map(function(p){
		p=p.toJSON();
		return formatProduct(p);
	});
});

//Lista de categorias desponivei
Parse.Cloud.define('get-category-list', async (request)=>{
	const queryCategories = new Parse.Query(Category);
	const resultCategories = await queryCategories.find({useMasterKey:true}); 
	return resultCategories.map(function(c){
		c = c.toJSON();
		return {
			id: c.objectId,
			title: c.title,
		}
	});
});

