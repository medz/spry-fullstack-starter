import 'package:spry/openapi.dart';
import 'package:spry/spry.dart';

import '../../mock_db.dart';

extension type Payload._(Map _) {
  String get name => _['name'];
  String get email => _['email'];
}

final handler = defineHandler((event) async {
  final Payload(:name, :email) = await event.request.json();
  final user = {
    "id": lastInsertUserId,
    "name": name,
    "email": email,
    "role": "Pending assignment",
    "team": "Unassigned",
    "location": "Remote",
    "status": "invited",
    "lastActiveLabel": "Invitation pending",
    "joinedLabel": "Invited today",
    "openTickets": 0,
    "projects": 0,
    "tags": ["new"],
    "bio": "Recently invited user awaiting onboarding and workspace setup.",
  };
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
              "email": .string(
                description: "The email of the user",
                minLength: 3,
              ),
            },
            requiredProperties: ["name", "email"],
          ),
        ),
      },
    ),
  ),
  responses: {
    "201": .inline(
      .new(
        description: "Created",
        content: {
          "application/json": .new(schema: .ref("#/components/schemas/User")),
        },
      ),
    ),
  },
);
