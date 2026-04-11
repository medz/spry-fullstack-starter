// ignore_for_file: file_names

import 'package:spry/spry.dart';

final _corsHeaders = Headers({
  'access-control-allow-origin': '*',
  'access-control-allow-methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
  'access-control-allow-headers':
      'Content-Type, Authorization, X-Requested-With',
  'access-control-expose-headers': 'Location',
  'access-control-max-age': '86400',
});

Future<Response> middleware(Event event, Next next) async {
  if (event.method == HttpMethod.options.value) {
    return Response(null, .new(status: 204, headers: _corsHeaders));
  }

  final response = await next();
  for (final MapEntry(:key, :value) in _corsHeaders.entries()) {
    response.headers.set(key, value);
  }

  return response;
}
