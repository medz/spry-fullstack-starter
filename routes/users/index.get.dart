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
          "name": .string(description: "User name"),
          "email": .string(description: "User email"),
          "role": .string(description: "Role"),
          "team": .string(description: "Team"),
          "location": .string(description: "Location"),
          "status": .string(
            description: "Account status",
            additional: {
              "enum": ["active", "invited", "suspended"],
            },
          ),
          "lastActiveLabel": .string(description: "Last active label"),
          "joinedLabel": .string(description: "Joined label"),
          "openTickets": .integer(description: "Open ticket count"),
          "projects": .integer(description: "Project count"),
          "tags": .array(.string(), description: "User tags"),
          "bio": .string(description: "Biography"),
        },
        description: "User schema",
        requiredProperties: [
          "id",
          "name",
          "email",
          "role",
          "team",
          "location",
          "status",
          "lastActiveLabel",
          "joinedLabel",
          "openTickets",
          "projects",
          "tags",
          "bio",
        ],
      ),
    },
  ),
);

final handler = defineHandler((_) => .json(users));
