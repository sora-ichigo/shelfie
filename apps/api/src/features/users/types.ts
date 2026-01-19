import type { User } from "../../db/schema/users.js";
import type { Builder } from "../../graphql/builder.js";

type UserObjectRef = ReturnType<typeof createUserRef>;

function createUserRef(builder: Builder) {
  return builder.objectRef<User>("User");
}

export let UserRef: UserObjectRef;

export function registerUserTypes(builder: Builder): void {
  UserRef = createUserRef(builder);

  UserRef.implement({
    description: "A user in the system",
    fields: (t) => ({
      id: t.exposeInt("id", {
        description: "The unique identifier of the user",
      }),
      email: t.exposeString("email", {
        description: "The email address of the user",
      }),
      createdAt: t.expose("createdAt", {
        type: "DateTime",
        description: "When the user was created",
      }),
      updatedAt: t.expose("updatedAt", {
        type: "DateTime",
        description: "When the user was last updated",
      }),
    }),
  });
}
