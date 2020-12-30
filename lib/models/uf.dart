class UF {

	UF({this.id, this.name, this.initials});

	int id;
	String initials;
	String name;

	factory UF.fromJson(Map<String, dynamic> json) => UF(
		id: json['id'], 
		name: json['nome'], 
		initials: json['sigla']
	);

	@override
	String toString() {
		return "UF{id: $id, name: $name, initials: $initials}";
	}

}