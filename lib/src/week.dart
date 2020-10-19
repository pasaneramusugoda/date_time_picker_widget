import 'package:flutter/foundation.dart';

import 'date.dart';

class Week {
  final int number;
  List<Date> days;

  Week({@required this.number, this.days});
}
