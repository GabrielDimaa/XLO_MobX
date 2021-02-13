import 'package:XLO_mobX/models/ad.dart';
import 'package:XLO_mobX/screens/ad/components/bottom_bar.dart';
import 'package:XLO_mobX/screens/ad/components/description_panel.dart';
import 'package:XLO_mobX/screens/ad/components/main_panel.dart';
import 'package:XLO_mobX/screens/ad/components/location_panel.dart';
import 'package:XLO_mobX/screens/ad/components/user_panel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class AdScreen extends StatelessWidget {
  final Ad ad;

  const AdScreen(this.ad);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Anúncio"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 280,
                child: Carousel(
                  images: ad.images
                      .map((url) => CachedNetworkImageProvider(url))
                      .toList(),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.orange,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainPanel(ad),
                    Divider(color: Colors.grey[500]),
                    DescriptionPanel(ad),
                    Divider(color: Colors.grey[500]),
                    LocationPanel(ad),
                    DescriptionPanel(ad),
                    UserPanel(ad),
                    SizedBox(height: 120)
                  ],
                ),
              ),
            ],
          ),
          BottomBar(ad),
        ],
      ),
    );
  }
}
