import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safestore/modules/home/component/price_card_widget.dart';
import 'package:safestore/modules/home/model/ad_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../ads/controller/customer_ads/customer_ads_bloc.dart';
import '../../home/model/product_model.dart';
import 'dart:math' as math;

class DashboardListProductCard extends StatelessWidget {
  final AdModel adModel;
  final Function deleteAd;
  const DashboardListProductCard({
    Key? key,
    required this.adModel,
    required this.deleteAd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userAdBloc = context.read<CustomerAdsBloc>();
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(0, 0),
                blurRadius: 3),
          ],
          color: Colors.white),
      child: InkWell(
        onTap: () {
          if (ModalRoute.of(context)!.settings.name!.contains("adDetails")) {
            Navigator.pushReplacementNamed(context, RouteNames.adDetails,
                arguments: adModel.slug);
          } else {
            Navigator.pushNamed(context, RouteNames.adDetails,
                arguments: adModel.slug);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Expanded(child: _buildContent(context, userAdBloc)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(context,userAdBloc) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.only(top: 5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: Border.fromBorderSide(
              BorderSide(color: Color(0xffd5d2d2), width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Cattegory Name
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.layers_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    "${adModel.category?.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                ),
                // Text('${productModel.rating}'),
              ],
            ),
          ),
          const SizedBox(height: 6),
          //Post Title
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    adModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      color: paragraphColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Active status and date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: adModel.status == "active" ? const Color(0xFF198754) : adModel.status == "sold" ? const Color(0xFF0DCAF0) : const Color(0xFFFFC107),
                  ),
                  child: Text(
                    adModel.status,
                    style: TextStyle(
                        color: adModel.status == "active" ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  DateFormat('d MMM yyyy').format(DateTime.parse("${adModel.createdAt}")),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          const Divider(
            color: Color(0xffd5d2d2),
          ),

          //Price and Edit delete option
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: adModel.price != 0,
                  child: Text(
                    '\$${adModel.price}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                  child: Row(
                    children: [

                      Visibility(
                        visible: false,
                        child: GestureDetector(
                          onTap: () {
                            // print('categoryID ${adModel.categoryId}');
                            // Navigator.pushNamed(context, RouteNames.adEditScreen,
                            //     arguments: widget.adModel);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFF198754)),
                            // child: Text('${adModel.galleries.length}'),
                            child: const Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: false,
                        child: GestureDetector(
                          onTap: () async {
                            Utils.loadingDialog(context);
                            final result = await userAdBloc.deleteMyAd(adModel.id);
                            result.fold((error) {
                              Utils.closeDialog(context);
                              Utils.showSnackBar(context, error.message);
                            }, (data) {
                              Utils.closeDialog(context);
                              deleteAd();
                              Utils.showSnackBar(context, data);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      /*decoration: BoxDecoration(
          color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF7))),
      ),*/
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Container(
              width: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: CustomImage(
                width: 120,
                fit: BoxFit.cover,
                path: adModel.thumbnail != ''
                    ? '${RemoteUrls.rootUrl3}${adModel.thumbnail}'
                    : null,
              ),
            ),
          ),
          Visibility(
            visible: adModel.featured == "1",
            child: Positioned(
              top: 17,
              left: -10,
              child: Transform.rotate(
                angle: -math.pi / 4.1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  decoration: BoxDecoration(
                      color: const Color(0xFF2DBE6C),
                      borderRadius: BorderRadius.circular(10)
                    // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                  ),
                  child: const Text('Featured',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}
