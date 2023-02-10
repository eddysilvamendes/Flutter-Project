//User Formater
function formatUser(userJson){
	return {
		id:userJson.objectId,
		fullNmae: userJson.fullName,
		email:userJson.email,
		address: userJson.address,
		phone: userJson.phone,
		token: userJson.sessionToken,
	}
}


//Sign Up
Parse.Cloud.define('signup',async (request)=>{
	const fullname = request.params.fullname;
	const address = request.params.address;
	const phone = request.params.phone;

	if(fullname==null) throw 'Invalid FullName';
	if(address==null) throw 'Invalid Address';
	if(phone==null) throw 'Invalid phone Number';

	const user = new Parse.User();
	user.set('username',request.params.email);
	user.set('email', request.params.email);
	user.set('password',request.params.password);
	user.set('fullname',fullname);
	user.set('phone',phone);
	user.set('address',address);
	user.set('isAdmin',request.params.isAdmin);

	try{
		const resultUser = await user.signUp(null,{useMasterKey:true});
		const userJson = resultUser.toJSON();
		return formatUser(userJson);
	}catch(e){
		throw 'Invalid Data';
	}
});

//Login
Parse.Cloud.define('login',async(request)=>{

	try {
		const user = await Parse.User.logIn(request.params.email, request.params.password);
		const userJson = user.toJSON();
		return formatUser(userJson);
	} catch (e) {
		throw 'Invalid Credentials'
	}
});

//validason de Token
Parse.Cloud.define('validate-token',async(request)=>{
	try {
		return formatUser(request.user.toJSON());
	} catch (error) {
		throw 'Invalid Token'
	}

});

//trocar a senha
Parse.Cloud.define('change-password',async(request)=>{
	
	if(request.user==null) throw 'Invalid User';
	const user = await Parse.User.logIn(request.params.email, request.params.currentPassword);
	if(user.id!= request.user.id) throw 'Invalid User';

	user.set('password',request.params.newPassword);
	await user.save(null,{useMasterKey:true});

});

//Reset de senha
Parse.Cloud.define('reset-password',async(request)=>{
	await Parse.User.requestPasswordReset(request.params.email);
	

});