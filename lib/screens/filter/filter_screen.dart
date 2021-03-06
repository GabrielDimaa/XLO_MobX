import 'package:XLO_mobX/screens/filter/components/order_by_field.dart';
import 'package:XLO_mobX/screens/filter/components/price_range_field.dart';
import 'package:XLO_mobX/screens/filter/components/vendor_type_field.dart';
import 'package:XLO_mobX/stores/filter_store.dart';
import 'package:XLO_mobX/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class FilterScreen extends StatelessWidget {

	final FilterStore filterStore = GetIt.I<HomeStore>().clonedFilter;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Filtrar Busca"),
				centerTitle: true
			),
			body: Center(
				child: Card(
					margin: const EdgeInsets.symmetric(horizontal: 32),
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(16),
					),
					elevation: 8,
					child: Padding(
						padding: const EdgeInsets.symmetric(horizontal: 16.0),
						child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              mainAxisSize: MainAxisSize.min,
							children: [
								OrderByField(filterStore),
								PriceRangeField(filterStore),
								VendorTypeField(filterStore),
                Observer(builder: (_) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    height: 50,
                    child: RaisedButton(
                      color: Colors.orange,
                      textColor: Colors.white,
                      disabledColor: Colors.orange.withAlpha(120),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text("Filtrar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      onPressed: filterStore.isFormValid ? () {
                        filterStore.save();
                        Navigator.of(context).pop();
                      } : null,
                    ),
                  );
                }),
							],
						),
					)
				)
			)
		);
	}
}