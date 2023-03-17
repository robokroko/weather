import 'package:flutter/material.dart';
import 'package:weather/utils/constans.dart' as constans;

class PopUpDialogs {
  static Color barrierColor = const Color(0xFF0F0E31);
  static bool isDialogOpen = false;
  static Color headerBackgroundColor = const Color(0xFF0F0E31);
  static Color dividerColor = constans.appYellow;
  static EdgeInsets insetPadding = const EdgeInsets.all(20.0);

  static Future<bool> openDialog({
    required BuildContext context,
    required String title,
    required String message,
    List<Widget>? actionButtons,
    Widget? leading,
    double height = 300.0,
    bool scrollable = false,
  }) async {
    if (PopUpDialogs.isDialogOpen) {
      debugPrint('Another dialog is already open.');
      return false;
    }
    PopUpDialogs.isDialogOpen = true;

    var result = await showDialog(
        context: context,
        barrierColor: barrierColor,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: scrollable,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(0.0),
            insetPadding: insetPadding,
            content: SizedBox(
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 80.0,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0, right: 0.0, bottom: 0.0),
                              child: InkWell(
                                child: Container(
                                  alignment: Alignment.topRight,
                                  padding: const EdgeInsets.all(2.0),
                                  height: 40.0,
                                  width: 40.0,
                                ),
                                onTap: () => Navigator.pop(context, false),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Color(0xFF0F0E31),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      message,
                      style: const TextStyle(color: Color(0xFF375169), fontSize: 16.0, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          width: 200.0,
                          height: 70.0,
                          color: Colors.transparent,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: constans.appYellow,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                color: Color(0xFF0F0E31),
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
    PopUpDialogs.isDialogOpen = false;
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }

  /// Opens an error alert dialog with "Error!" as title, one button with "ok" text and
  /// [message] as the content text.
  static Future<bool> openAlertDialog({
    required BuildContext context,
    required String message,
    Widget? leading,
    String? title,
    double height = 260.0,
  }) async {
    return await openDialog(
      context: context,
      height: height,
      title: title ?? 'Error',
      message: message,
    );
  }

  /// Hides any open Dialog (only if [isDialogOpen]).
  static void hide(BuildContext context) {
    if (PopUpDialogs.isDialogOpen) {
      PopUpDialogs.isDialogOpen = false;
      Navigator.pop(context);
    }
  }

  /// Hides any open BATDialog (only if [isDialogOpen]).
  ///
  /// Uses [NavigatorState] instead of [BuildContext]. Should be used at async gaps.
  static void hideWithNavigator(NavigatorState navigatorState) {
    if (PopUpDialogs.isDialogOpen) {
      debugPrint('Closing dialog.');
      PopUpDialogs.isDialogOpen = false;
      navigatorState.pop(false);
    } else {
      debugPrint('Dialog is not open. Nothing to close.');
    }
  }

  // Another way to check if dialog is open (depends on navigation stack instead of static bool)
  //_isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;
}
