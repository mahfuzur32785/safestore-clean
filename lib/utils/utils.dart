import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:safestore/core/router_name.dart';
import 'package:safestore/utils/k_images.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'constants.dart';

class Utils {
  static final _selectedDate = DateTime.now();

  static final _initialTime = TimeOfDay.now();

  static String formatPrice(var price) {
    if (price is double) return price.toStringAsFixed(2);
    if (price is String) {
      final p = double.tryParse(price) ?? 0.0;
      return p.toStringAsFixed(2);
    }
    return "${price.toStringAsFixed(2)}";
  }

  static String formatPriceIcon(var price, String icon) {
    if (price is double) return icon + price.toStringAsFixed(2);
    if (price is String) {
      final p = double.tryParse(price) ?? 0.0;
      return icon + p.toStringAsFixed(2);
    }
    return icon + price.toStringAsFixed(2);
  }

  static Future<bool>  appLaunchUrl(url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      await launchUrl(uri,mode: LaunchMode.externalNonBrowserApplication);
      return true;
    } else {
      if (kDebugMode) {
        print('Could not launch $uri');
      }
      return false;
      throw 'Could not launch $uri';
    }
  }
  static Future<bool>  sendEmail(uri) async {
    if (await canLaunchUrl(uri)) {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      await launchUrl(uri,mode: LaunchMode.externalNonBrowserApplication);
      return true;
    } else {
      if (kDebugMode) {
        print('Could not launch $uri');
      }
      return false;
      throw 'Could not launch $uri';
    }
  }

  static String formatDate(var date) {
    late DateTime dateTime;
    if (date is String) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = date;
    }

    return DateFormat.yMd().format(dateTime.toLocal());
  }
  static String formatDateByMoth(var date) {
    var format = DateFormat("MMM dd, yyyy");
    late DateTime dateTime;
    if (date is String) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = date;
    }

    return format.format(dateTime.toLocal());
  }

  static String formatDateWithTime(var date) {
    var formatter = DateFormat("yyyy-MM-dd hh:mm aa");
    late DateTime dateTime;
    if (date is String) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = date;
    }

    // return formatter.format(dateTime.toLocal());
    return formatter.format(dateTime);
  }

  static String numberCompact(num number) =>
      NumberFormat.compact().format(number);

  static String timeAgo(String? time) {
    try {
      if (time == null) return '';
      return timeago.format(DateTime.parse(time));
    } catch (e) {
      return '';
    }
  }

  static double toDouble(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static String dropPricePercentage(int priceS, int offerPriceS) {
    double price = priceS.toDouble();
    double offerPrice = offerPriceS.toDouble();
    double dropPrice = (price - offerPrice) * 100;

    double percentage = dropPrice / price;
    return "-${percentage.toStringAsFixed(2)}%";
  }

  static double toInt(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) => showDatePicker(
    context: context,
    initialDate: _selectedDate,
    firstDate: DateTime(1990, 1),
    lastDate: DateTime(2050),
  );

  static Future<TimeOfDay?> selectTime(BuildContext context) =>
      showTimePicker(context: context, initialTime: _initialTime);

  static loadingDialog(
      BuildContext context, {
        bool barrierDismissible = false,
      }) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: const SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future showCustomDialog(
      BuildContext context, {
        Widget? child,
        bool barrierDismissible = false,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }

  static int calculateMaxDays(String startDate, String endDate) {
    final startDateTime = DateTime.parse(startDate);
    final endDateTime = DateTime.parse(endDate);
    final totalDays = endDateTime.difference(startDateTime).inDays;

    return totalDays >= 0 ? totalDays : 0;
  }

  static int calculateRemainingHours(String startDate, String endDate) {
    final startDateTime =
    DateTime.now().toLocal().subtract(const Duration(days: 9));
    final endDateTime = DateTime.parse(endDate).toLocal();
    final totalHours = endDateTime.difference(startDateTime).inHours;

    if (totalHours < 0) return 24;

    return 24 - (totalHours % 24);
  }

  static int calculateRemainingMinutes(String startDate, String endDate) {
    final startDateTime = DateTime.now().toLocal();
    final endDateTime = DateTime.parse(endDate).toLocal();
    final totalMinutes = endDateTime.difference(startDateTime).inMinutes;

    if (totalMinutes < 0) return 60;

    return 60 - (totalMinutes % (24 * 60));
  }

  static int calculateRemainingDays(String startDate, String endDate) {
    final endDateTime = DateTime.parse(endDate).toLocal();
    final totalDaysGone =
        endDateTime.difference(DateTime.now().toLocal()).inDays;
    final totalDays = calculateMaxDays(startDate, endDate);
    return totalDaysGone >= 0 ? totalDays - totalDaysGone : totalDays;
  }

  /// Checks if string is a valid username.
  static bool isUsername(String s) =>
      hasMatch(s, r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  /// Checks if string is Currency.
  static bool isCurrency(String s) => hasMatch(s,
      r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R\$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$');

  /// Checks if string is phone number.
  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is email.
  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static bool isEmpty(dynamic value) {
    if (value is String) {
      return value.toString().trim().isEmpty;
    }
    if (value is Iterable || value is Map) {
      return value.isEmpty ?? false;
    }
    return false;
  }

  static void errorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          content: Text(errorMsg, style: const TextStyle(color: Colors.red)),
        ),
      );
  }

  static void showSnackBar(BuildContext context, String msg,
      [Color textColor = primaryColor]) {
    final snackBar =
    SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSnackBarWithAction(
      BuildContext context, String msg, VoidCallback onPress,{String actionText = 'Active',Color textColor = primaryColor,}) {
    final snackBar = SnackBar(
      content: Text(msg, style: TextStyle(color: textColor)),
      action: SnackBarAction(
        label: actionText,
        textColor: Colors.white,
        onPressed: onPress,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static dateFormat(String date){
    return DateFormat('d MMM yyyy').format(DateTime.parse(date));
  }

  // static double getRating(List<DetailsProductReviewModel> productReviews) {
  //   if (productReviews.isEmpty) return 0;
  //
  //   double rating = productReviews.fold(
  //       0.0,
  //           (previousValue, element) =>
  //       previousValue + element.rating.toDouble());
  //   rating = rating / productReviews.length;
  //   return rating;
  // }

  static loadingDialogWithText(
      BuildContext context, {
        String text = '',
        bool barrierDismissible = false,
      }) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        child: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 16,
            ),
            Text(text),
          ],
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.pop(context);
    }
  }

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool isShowFavorite(BuildContext context){
    var routeName = ModalRoute.of(context)?.settings.name;
    return routeName == RouteNames.adDetails || routeName == RouteNames.adsScreen || routeName == RouteNames.mainPage ||routeName == RouteNames.publicShopScreen || routeName == RouteNames.wishListScreen;
  }

  static String paymentIcon(String type){
    var icon = type.toLowerCase().contains("paypal") ? Kimages.paypalIcon : Kimages.stripeIcon;
    return icon;
  }

  static Future<String?> pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  static Future<CroppedFile?> cropper(path,x,y)async {
    return await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: CropAspectRatio(ratioX: x, ratioY: y),
      compressQuality: 100,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: redColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
        // WebUiSettings(
        //   context: context,
        // ),
      ],
    );
  }

  static Route createPageRouteTop(BuildContext context,Widget page){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 0.1);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  static void openSignInDialog(context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Need to sign in"),
          content: SizedBox(
            height: 240,
            child: Center(
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, RouteNames.authenticationScreen);
                    },
                    child: const Text("Sign in Please")),
              ),
            ),
          ),
          actions: [
            SizedBox(
                height: 45,
                child: OutlinedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("Cancel")))
          ],
        );
      },
    );
  }

  //............ Toast Message ............
  static void toastMsg(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.7),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static String orderStatus(String orderStatus) {
    switch (orderStatus) {
      case '0':
        return 'Pending';
      case '1':
        return 'Progress';
      case '2':
        return 'Delivered';
      case '3':
        return 'Completed';
    // case '4':
    //   return 'Declined';
      default:
        return 'Declined';
    }
  }

  static IconData getSocialIcon(String value){
    switch(value) {
      case 'facebook':
        return FontAwesomeIcons.facebook;
      case 'twitter':
        return FontAwesomeIcons.twitter;
      case 'instagram':
        return FontAwesomeIcons.instagram;
      case 'youtube':
        return FontAwesomeIcons.youtube;
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      case 'pinterest':
        return FontAwesomeIcons.pinterest;
      case 'reddit':
        return FontAwesomeIcons.reddit;
      case 'github':
        return FontAwesomeIcons.github;
      case 'other':
        return FontAwesomeIcons.link;
      default:
        return FontAwesomeIcons.link;
    }

  }
  static Color getSocialIconColor(String value){
    switch(value) {
      case 'facebook':
        return const Color(0xff3b5998);
      case 'twitter':
        return Colors.lightBlue;
      case 'instagram':
        return const Color(0xff962fbf);
      case 'youtube':
        return const Color(0xffFF0000);
      case 'linkedin':
        return const Color(0xff0072b1);
      case 'pinterest':
        return const Color(0xffc8232c);
      case 'reddit':
        return const Color(0xFFED001C);
      case 'github':
        return const Color(0xff171515);
      case 'other':
        return Colors.lightBlue;
      default:
        return redColor;
    }

  }
}
