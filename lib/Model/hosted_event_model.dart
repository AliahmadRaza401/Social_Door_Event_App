import 'package:flutter/widgets.dart';

class HostedEventModel {
  var id;
  var title;
  var categoreyId;
  var categoryName;
  var eventCharges;
  var eventThumbNail;
  var hostedDate;

  HostedEventModel({
    @required this.id,
    @required this.title,
    @required this.categoreyId,
    @required this.categoryName,
    @required this.eventCharges,
    @required this.eventThumbNail,
    @required this.hostedDate,
  });
}
