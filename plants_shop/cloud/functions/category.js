const Category = Parse.Object.extend('Category');
Parse.Cloud.define("create_category",async (request)=>{
	//if(request.user== null)throw "Need Authentication";
	  

	
	  const category = new Category();
	  category.set("title",request.params.title);
	  
	  category.set("isActive",request.params.isActive);
	  const savedCategory = await category.save(null,{useMasterKey:true});
	 return savedCategory.id;
	});