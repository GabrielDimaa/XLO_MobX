enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  
	User({
		this.id,
		this.name, 
		this.email, 
		this.phone, 
		this.password, 
		this.type = UserType.PARTICULAR,
		this.createdAt
	});

	String id;
	String name;
	String phone;
	String email;
	String password;
	UserType type;
	DateTime createdAt;

	@override
	String toString() {
		return 'User{id: $id, name: $name, phone: $phone, email: $email, password: $password, type: $type, createdAt: $createdAt}';
	}

}
