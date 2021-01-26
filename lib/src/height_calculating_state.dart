import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optional/optional.dart';

abstract class HeightCalculatingState<S extends StatefulWidget>
    extends State<S> {
  final screenHeightFactor = 0.45;
  final List<GlobalKey> _keys = [];
  Optional<double> calculatedHeight = Optional.empty();

  Key addKey() {
    GlobalKey key = GlobalKey();
    _keys.add(key);

    return key;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        calculateHeight();
      });
    });
  }

  void recalculateHeight() {
    Future.delayed(Duration(milliseconds: 100), () {
      calculatedHeight = Optional.empty();
      calculateHeight();
    });
  }

  void calculateHeight() {
    if (calculatedHeight.isEmpty) {
      setState(() {
        final listHeight = _keys.fold(0.0, (pv, e) {
          RenderBox box = e.currentContext.findRenderObject();
          print("box");

          return pv += box.size.height;
        });
        calculatedHeight = Optional.of(listHeight);

        print(calculatedHeight);
      });
    }
  }
}
