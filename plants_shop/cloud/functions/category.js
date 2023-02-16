const Category = Parse.Object.extend('Category');
Parse.Cloud.define("create_category",async (request)=>{
	//if(request.user== null)throw "Need Authentication";

	  const category = new Category();
	  category.set("title",request.params.title);
	  
	  category.set("isActive",request.params.isActive);
	  const savedCategory = await category.save(null,{useMasterKey:true});
	 return savedCategory.id;
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
			isActive: c.isActive,
		}
	});
});