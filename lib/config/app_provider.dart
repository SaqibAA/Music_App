import 'package:music_app/features/features.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<AuthProvider>(
    create: (context) => AuthProvider(),
  ),
   ChangeNotifierProvider<PlaylistProvider>(
    create: (context) => PlaylistProvider(),
  ),
];