import 'package:flutter/foundation.dart';

safePrint(String text) {
  if (kDebugMode) {
    print("<----------- safePrint ----------->");
    print(text);
    print("<----------- safePrint ----------->");

  }
}