import 'package:XLO_mobX/models/category.dart';
import 'package:XLO_mobX/repositories/parse_errors.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:XLO_mobX/repositories/table_keys.dart';

class CategoryRepository {

	Future<List<Category>> getList() async {
		final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
			..orderByAscending(keyCategoryDescription);

		final response = await queryBuilder.query();

		if(response.success) {
			return response.results.map((parse) => Category.fromParse(parse)).toList();
		} else {
			throw ParseErrors.getDescription(response.error.code);
		}
	}

}