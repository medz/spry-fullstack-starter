import 'package:unrouter/flutter.dart';

import 'pages/create.dart';
import 'pages/details.dart';
import 'pages/home.dart';

final router = createRouter(
  routes: const [
    Inlet(name: 'home', path: '/', view: HomePage.new),
    Inlet(name: 'create', path: '/users/new', view: CreatePage.new),
    Inlet(name: 'details', path: '/users/:id', view: DetailsPage.new),
  ],
);
