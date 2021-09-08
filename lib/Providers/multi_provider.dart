import 'package:provider/provider.dart';
import 'package:social_door/Screens/Authentication/dataProvider.dart';
import 'package:social_door/Screens/Home/home_provider.dart';
import 'package:social_door/Screens/create_Event/create_event_provider.dart';

final multiProvider = [
  ChangeNotifierProvider<CreateEventProvider>(
    create: (_) => CreateEventProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<DataProvider>(
    create: (_) => DataProvider(),
    lazy: true,
  ),
   ChangeNotifierProvider<HomeProvider>(
    create: (_) => HomeProvider(),
    lazy: true,
  ),
];
