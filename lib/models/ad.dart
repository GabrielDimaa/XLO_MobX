import 'package:XLO_mobX/models/address.dart';
import 'package:XLO_mobX/models/category.dart';
import 'package:XLO_mobX/models/user.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {

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