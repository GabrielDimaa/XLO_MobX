import 'package:XLO_mobX/screens/filter/components/order_by_field.dart';
import 'package:XLO_mobX/screens/filter/components/price_range_field.dart';
import 'package:XLO_mobX/screens/filter/components/vendor_type_field.dart';
import 'package:XLO_mobX/stores/filter_store.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {

	final FilterStore filterStore = FilterStore();

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
							mainAxisSize: MainAxisSize.min,
							children: [
								OrderByField(filterStore),
								PriceRangeField(filterStore),
								VendorTypeField(filterStore)
							],
						),
					)
				)
			)
		);
	}
}