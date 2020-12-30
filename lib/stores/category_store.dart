import 'package:XLO_mobX/models/category.dart';
import 'package:XLO_mobX/repositories/category_repository.dart';
import 'package:mobx/mobx.dart';
part 'category_store.g.dart';

class CategoryStore = _CategoryStoreBase with _$CategoryStore;

abstract class _CategoryStoreBase with Store {

	_CategoryStoreBase() {
		_loadCategories();
	}

	ObservableList<Category> categoryList = ObservableList<Category>();

	@computed
	List<Category> get allCategoryList => List.from(categoryList)
		..insert(0, Category(id: '*', description: 'Todas'));

	@observable
	String error;

	@action
	void setError(String value) => error = value;

	@action
	void setCategories(List<Category> categories) {
		categoryList.clear();
		categoryList.addAll(categories);
	}

	Future<void> _loadCategories() async {
		try {
			final categories = await CategoryRepository().getList();
			setCategories(categories);
		} catch (e) {
			setError(e);
		}
	}
  
}