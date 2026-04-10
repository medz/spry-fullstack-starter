import 'dart:convert';

import 'package:spry/openapi.dart';
import 'package:spry/spry.dart';

import '../../mock_db.dart';

final openapi = OpenAPI(
  tags: ["User"],
  summary: "Get a user by ID",
  description: "Returns a user by their ID.",
  responses: {
    "200": .inline(
      .new(
        description: "OK",
        content: {
          "application/json": .new(schema: .ref("#/components/schemas/User")),
        },
      ),
    ),
    "404": .inline(
      .new(
        description: "Not Found",
        content: {
          "application/json": .new(
            schema: .object({"message": .string(description: "Error message")}),
          ),
        },
      ),
    ),
  },
);

final handler = defineHandler((event) {
  final id = event.params.decode('id', int.parse);
  final user = users.where((e) => e['id'] == id).firstOrNull;
  if (user == null) {
    throw HTTPError(
      404,
      body: json.encode({"message": "User not found"}),
      headers: .new({"Content-Type": "application/json"}),
    );
  }

  return .json(user, .new(status: 200));
});
