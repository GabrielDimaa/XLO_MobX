import 'package:XLO_mobX/screens/filter/components/section_title.dart';
import 'package:XLO_mobX/stores/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class VendorTypeField extends StatelessWidget {

	VendorTypeField(this.filter);

	final FilterStore filter;

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				SectionTitle("Tipo de anunciante"),
				Observer(builder: (_) {
				   	return Wrap(
					  	children: [
							GestureDetector(
								onTap: () {
									if(filter.isTypeParticular) {
										if(filter.isTypeProfessional)
											filter.resetVendorType(VENDOR_TYPE_PARTICULAR);
										else
											filter.selectVendorType(VENDOR_TYPE_PROFESSIONAL);
									} else {
										filter.setVendorType(VENDOR_TYPE_PARTICULAR);
									}
								},
								child: Container(
									height: 50,
									width: 120,
									decoration: BoxDecoration(
										borderRadius: BorderRadius.circular(25),
										color: filter.isTypeParticular ? 
											Colors.purple :
											Colors.purple[200],
									),
									alignment: Alignment.center,
									child: Text("Particular",
										style: TextStyle(color: Colors.white)
									)
								),
							),
							SizedBox(width: 12),
							GestureDetector(
								onTap: () {
									if(filter.isTypeProfessional) {
										if(filter.isTypeParticular)
											filter.resetVendorType(VENDOR_TYPE_PROFESSIONAL);
										else
											filter.selectVendorType(VENDOR_TYPE_PARTICULAR);
									} else {
										filter.setVendorType(VENDOR_TYPE_PROFESSIONAL);
									}
								},
								child: Container(
									height: 50,
									width: 130,
									decoration: BoxDecoration(
										borderRadius: BorderRadius.circular(25),
										color: filter.isTypeProfessional ? 
											Colors.purple :
											Colors.purple[200],
									),
									alignment: Alignment.center,
									child: Text("Professional",
										style: TextStyle(color: Colors.white)
									)
								),
							)
						]
					);
				})
			]
		);
	}
}