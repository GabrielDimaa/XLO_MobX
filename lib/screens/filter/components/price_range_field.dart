import 'package:XLO_mobX/screens/filter/components/price_field.dart';
import 'package:XLO_mobX/screens/filter/components/section_title.dart';
import 'package:XLO_mobX/stores/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PriceRangeField extends StatelessWidget {

	PriceRangeField(this.filter);

	final FilterStore filter;

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				SectionTitle("Preço"),
				Row(
					children: [
						PriceField(
							label: "min",
							onChanged: filter.setMinPrice,
							initialValue: filter.minPrice
						),
						const SizedBox(width: 12,),
						PriceField(
							label: "max",
							onChanged: filter.setMaxPrice,
							initialValue: filter.maxPrice
						),

					]
				),
				Observer(builder: (_) {
				   	if(filter.priceError != null) 
						return Padding(
							padding: const EdgeInsets.only(top: 8.0),
							child: Text(filter.priceError, 
								style: TextStyle(color: Colors.redAccent, fontSize: 12)
							),
						);
				   	return Container();
				})
			]
		);
	}
}