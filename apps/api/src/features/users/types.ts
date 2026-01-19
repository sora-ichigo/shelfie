interface FieldBuilder {
  exposeInt: (field: string, opts: { description: string }) => unknown;
  exposeString: (field: string, opts: { description: string }) => unknown;
  expose: (
    field: string,
    opts: { type: string; description: string },
  ) => unknown;
}

interface PothosBuilder {
  objectType: (
    name: string,
    options: {
      description: string;
      fields: (t: FieldBuilder) => Record<string, unknown>;
    },
  ) => void;
}

export function registerUserTypes(builder: unknown): void {
  const schemaBuilder = builder as PothosBuilder;

  schemaBuilder.objectType("User", {
    description: "A user in the system",
    fields: (t: FieldBuilder) => ({
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
