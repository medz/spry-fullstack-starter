import 'package:spry/openapi.dart';
import 'package:spry/spry.dart';

import '../../mock_db.dart';

extension type Payload._(Map _) {
  String get name => _['name'];
}

final handler = defineHandler((event) async {
  final Payload(:name) = await event.request.json();
  final user = {"id": lastInsertUserId, "name": name};
  users.add(user);

  return .json(user, .new(status: 201));
});

final openapi = OpenAPI(
  tags: ["User"],
  summary: "Create a new user",
  requestBody: .inline(
    .new(
      required: true,
      content: {
        "application/json": .new(
          schema: .object(
            {
              "name": .string(
                description: "The name of the user",
                minLength: 1,
              ),
            },
            requiredProperties: ["name"],
          ),
        ),
      },
    ),
  ),
  responses: {
    "200": .inline(
      .new(
        description: "OK",
        content: {
          "application/json": .new(schema: .ref("#/components/schemas/User")),
        },
      ),
    ),
  },
);
