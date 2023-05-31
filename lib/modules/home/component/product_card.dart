import 'package:safestore/modules/authentication/controllers/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:safestore/modules/home/component/price_card_widget.dart';
import 'package:safestore/modules/home/model/ad_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:safestore/widgets/compare_button.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import 'dart:math' as math;

class ProductCard extends StatefulWidget {
  final AdModel? adModel;
  final double? width;
  final String? from;
  final int? index;
  final int? myId;
  final int? sellerId;
  final int? logInUserId;

  const ProductCard({
    Key? key,
    this.adModel,
    this.width,
    this.from,
    this.index,
    this.myId,
    this.sellerId,
    this.logInUserId
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.adDetails,
              arguments: widget.adModel!.slug);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.from == 'home' || widget.from=='ads_page' ? Expanded(child: _buildImage()) : widget.from =='public_shop' ? _buildImage() : SizedBox(),
            widget.from == 'public_shop' ? Expanded(child: _buildContent(context)) : widget.from =='home' || widget.from=='ads_page' ? _buildContent(context) : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: widget.from == 'public_shop' ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Visibility(
            visible: widget.adModel!.price.toString().isNotEmpty,
            child: Text(
              "\$${widget.adModel?.price.toString()}.00",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: redColor, fontSize: widget.from =='public_shop' ? 14 : 18, fontWeight: FontWeight.bold),
            ),
          ),
          widget.from =='public_shop' ? SizedBox() : SizedBox(height: 2),
          SizedBox(
            child: Text(
              "${widget.adModel?.title}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          widget.from =='public_shop' ? SizedBox(height: 5) : SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                // visible: widget.myId != widget.sellerId,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () async{
                          print("Compare");
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey.shade200,
                          child: CompareButton(
                            index: int.parse("${widget.adModel?.id}"),
                            adsUserId: widget.adModel!.userId,
                            logInUserId: widget.logInUserId,
                            productId: int.parse("${widget.adModel?.id}"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey.shade200,
                        child: FavoriteButton(
                          productId: widget.adModel!.id,
                          isFav: widget.adModel!.is_wishlist,
                          from: widget.from,
                          adsUserId: widget.adModel!.userId,
                          logInUserId: widget.logInUserId,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ashColor)),
      ),
      height: 60,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            child: CustomImage(
                // path: RemoteUrls.imageUrl(productModel.image),
                path: widget.adModel!.thumbnail != ''
                    ? '${RemoteUrls.rootUrl3}${widget.adModel!.thumbnail}'
                    : null,
                // path: adModel.imageUrl != '' ? adModel.imageUrl : null,
                fit: BoxFit.cover),
          ),
          Visibility(
            visible: "${widget.adModel?.featured}" == "1",
            child: Positioned(
              top: 5,
              left: -10,
              child: Transform.rotate(
                angle: -math.pi / 4.1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                      color: const Color(0xFF2DBE6C),
                      borderRadius: BorderRadius.circular(10)
                    // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                  ),
                  child: const Text('Featured',style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ),

          // _buildOfferInPercentage(),
          widget.from=='home'||widget.from=='public_shop'||widget.from=='ads_page' ? Container() : Positioned(
            top: 8,
            left: 8,
            child:
            FavoriteButton(productId: widget.adModel!.id, isFav: widget.adModel!.is_wishlist),
          ),
        ],
      ),
    );
  }
}
