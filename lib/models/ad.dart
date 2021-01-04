import 'package:XLO_mobX/models/address.dart';
import 'package:XLO_mobX/models/category.dart';
import 'package:XLO_mobX/models/city.dart';
import 'package:XLO_mobX/models/uf.dart';
import 'package:XLO_mobX/models/user.dart';
import 'package:XLO_mobX/repositories/table_keys.dart';
import 'package:XLO_mobX/repositories/user_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {

	Ad();

	Ad.fromParse(ParseObject object) {
		id = object.objectId;
		title = object.get<String>(keyAdTitle);
		description = object.get<String>(keyAdDescription);
		images = object.get<List>(keyAdImages).map((e) => e.url).toList();
		hidePhone = object.get<bool>(keyAdHidePhone);
		price = object.get<num>(keyAdPrice);
		createdAt = object.createdAt;
		address = Address(
			district: object.get<String>(keyAdDistrict),
			city: City(name: object.get<String>(keyAdCity)),
			cep: object.get<String>(keyAdPostalCode),
			uf: UF(initials: object.get<String>(keyAdFederativeUnit))
		);
		views = object.get<int>(keyAdViews, defaultValue: 0);
		user = UserRepository().mapParsetoUser(object.get<ParseUser>(keyAdOwner));
		category = Category.fromParse(object.get<ParseObject>(keyAdCategory));
		status = AdStatus.values[object.get<int>(keyAdStatus)];
	}

	String id;

	List images;

	String title;
	String description;

	Category category;

	Address address;

	num price;
	bool hidePhone;

	AdStatus status = AdStatus.PENDING;
	DateTime createdAt;

	User user;

	int views;

}