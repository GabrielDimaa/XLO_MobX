import 'package:XLO_mobX/stores/home_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'filter_store.g.dart';

enum OrderBy { DATE , PRICE }

const VENDOR_TYPE_PARTICULAR = 1 << 0;
const VENDOR_TYPE_PROFESSIONAL = 1 << 1;

class FilterStore = _FilterStoreBase with _$FilterStore;

abstract class _FilterStoreBase with Store {

  _FilterStoreBase({this.maxPrice, this.minPrice, this.orderBy = OrderBy.DATE, this.vendorType = VENDOR_TYPE_PARTICULAR});
  
	@observable
	OrderBy orderBy = OrderBy.DATE;

	@action 
	void setOrderBy(OrderBy value) => orderBy = value;

	@observable
	int minPrice;

	@action
	void setMinPrice(int value) => minPrice = value;

	@observable
	int maxPrice;

	@action
	void setMaxPrice(int value) => maxPrice = value;

	@computed
	String get priceError => maxPrice != null && minPrice != null
		&& maxPrice < minPrice ? 
		"Faixa de preço inválida" : null;

	@observable
	int vendorType = VENDOR_TYPE_PARTICULAR;

	@action
	void selectVendorType(int value) => vendorType = value;
	void setVendorType(int type) => vendorType = vendorType | type;
	void resetVendorType(int type) => vendorType = vendorType & ~type;

	@computed
	bool get isTypeParticular => vendorType & VENDOR_TYPE_PARTICULAR != 0;
	bool get isTypeProfessional => vendorType & VENDOR_TYPE_PROFESSIONAL != 0;

  @computed
  bool get isFormValid => priceError == null;

  void save() {
    GetIt.I<HomeStore>().setFilter(this);
  }

  FilterStore clone() {
    return FilterStore(
      orderBy: orderBy,
      maxPrice: maxPrice,
      minPrice: minPrice,
      vendorType: vendorType
    );
  }

}