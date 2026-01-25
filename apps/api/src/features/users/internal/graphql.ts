import type { User } from "../../../db/schema/users.js";
import type { Builder } from "../../../graphql/builder.js";
import type { BookShelfRepository } from "../../books/internal/book-shelf-repository.js";
import type { UserService } from "./service.js";

type UserObjectRef = ReturnType<typeof createUserRef>;

function createUserRef(builder: Builder) {
  return builder.objectRef<User>("User");
}

export let UserRef: UserObjectRef;

export interface ValidationErrorData {
  code: "VALIDATION_ERROR";
  message: string;
  field: string | null;
}

export class ValidationError extends Error implements ValidationErrorData {
  code: "VALIDATION_ERROR" = "VALIDATION_ERROR";
  field: string | null;

  constructor(message: string, field: string | null = null) {
    super(message);
    this.field = field;
    this.name = "ValidationError";
  }

  toData(): ValidationErrorData {
    return {
      code: this.code,
      message: this.message,
      field: this.field,
    };
  }
}

function createUpdateProfileInputRef(builder: Builder) {
  return builder.inputRef<{ name: string }>("UpdateProfileInput");
}

type UpdateProfileInputRef = ReturnType<typeof createUpdateProfileInputRef>;

let UpdateProfileInputRef: UpdateProfileInputRef | null = null;

export { UpdateProfileInputRef };

let bookShelfRepositoryInstance: BookShelfRepository | null = null;

export function registerUserTypes(
  builder: Builder,
  bookShelfRepository?: BookShelfRepository,
): void {
  bookShelfRepositoryInstance = bookShelfRepository ?? null;

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
      name: t.exposeString("name", {
        description: "The display name of the user",
        nullable: true,
      }),
      avatarUrl: t.exposeString("avatarUrl", {
        description: "The URL of the user's avatar image",
        nullable: true,
      }),
      createdAt: t.expose("createdAt", {
        type: "DateTime",
        description: "When the user was created",
      }),
      updatedAt: t.expose("updatedAt", {
        type: "DateTime",
        description: "When the user was last updated",
      }),
      bookCount: t.int({
        description: "The number of books in the user's shelf",
        nullable: false,
        resolve: async (user) => {
          if (!bookShelfRepositoryInstance) {
            return 0;
          }
          return bookShelfRepositoryInstance.countUserBooks(user.id);
        },
      }),
    }),
  });

  builder.objectType(ValidationError, {
    name: "ValidationError",
    description: "Validation error for user input",
    fields: (t) => ({
      code: t.exposeString("code", {
        description: "Error code",
      }),
      message: t.exposeString("message", {
        description: "Human-readable error message",
      }),
      field: t.string({
        description: "Field that caused the error, if applicable",
        nullable: true,
        resolve: (parent) => parent.field,
      }),
    }),
  });

  UpdateProfileInputRef = createUpdateProfileInputRef(builder);
  UpdateProfileInputRef.implement({
    description: "Input for updating user profile",
    fields: (t) => ({
      name: t.string({ required: true, description: "User display name" }),
    }),
  });
}

export function registerUserMutations(
  builder: Builder,
  userService: UserService,
): void {
  builder.mutationFields((t) => ({
    updateProfile: t.field({
      type: UserRef,
      description: "Update the current user's profile",
      errors: {
        types: [ValidationError],
      },
      authScopes: {
        loggedIn: true,
      },
      args: {
        input: t.arg({
          // biome-ignore lint/style/noNonNullAssertion: initialized in registerUserTypes
          type: UpdateProfileInputRef!,
          required: true,
        }),
      },
      resolve: async (_parent, { input }, context): Promise<User> => {
        if (!context.user) {
          throw new ValidationError("認証が必要です");
        }

        const userResult = await userService.getUserByFirebaseUid(
          context.user.uid,
        );
        if (!userResult.success) {
          throw new ValidationError("ユーザーが見つかりません");
        }

        const result = await userService.updateProfile({
          userId: userResult.data.id,
          name: input.name,
        });

        if (!result.success) {
          throw new ValidationError(result.error.message);
        }

        return result.data;
      },
    }),
  }));
}
