import 'package:spry/spry.dart';
import 'package:spry/openapi.dart';

import '../../mock_db.dart';

final openapi = OpenAPI(
  tags: ["User"],
  summary: "Get all users",
  description: "Returns a list of all users",
  responses: {
    "200": .inline(
      .new(
        description: "OK",
        content: {
          "application/json": .new(
            schema: .array(
              .ref("#/components/schemas/User"),
              description: "User list",
            ),
          ),
        },
      ),
    ),
  },
  globalComponents: .new(
    schemas: {
      "User": .object(
        {
          "id": .integer(description: "User ID"),
          "name": .string(description: "User Name"),
        },
        description: "User Schema",
        requiredProperties: ["id", "name"],
      ),
    },
  ),
);

final handler = defineHandler((_) => .json(users));
