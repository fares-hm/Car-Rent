import 'package:flutter/cupertino.dart';

class ScreenSizeT {
  late BuildContext _context;
  late double height;
  late double width;


  ScreenSizeT(BuildContext context) {
    this._context = context;
    height = MediaQuery.of(_context).size.height;
    width = MediaQuery.of(_context).size.width;
  }
}
