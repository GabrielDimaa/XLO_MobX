import 'package:XLO_mobX/screens/filter/components/section_title.dart';
import 'package:XLO_mobX/stores/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class OrderByField extends StatelessWidget {

	OrderByField(this.filter);

	final FilterStore filter;

	@override
	Widget build(BuildContext context) {

		Widget buildOption(String title, OrderBy option) {
			return GestureDetector(
				onTap: () {
					filter.setOrderBy(option);
				},
				child: Container(
					height: 50,
					alignment: Alignment.center,
					padding: const EdgeInsets.symmetric(horizontal: 24),
					decoration: BoxDecoration(
						borderRadius: BorderRadius.circular(25),
						color: filter.orderBy == option ? Colors.purple : Colors.purple[200]
					),
					child: Text(title,
						style: TextStyle(
							color: Colors.white
						)
					)
				),
			);
		}

		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				SectionTitle("Ordenar por"),
				Observer(builder: (_) {
				   return Row(
						children: [
							buildOption("Data", OrderBy.DATE),
							const SizedBox(width: 12),
							buildOption("Preço", OrderBy.PRICE)
						],
					);
				})
			],
		);
	}
}