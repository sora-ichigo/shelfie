import type { User } from "../../../db/schema/users.js";
import {
  type DomainError,
  err,
  ok,
  type Result,
} from "../../../errors/result.js";
import type { UserRepository } from "./repository.js";

export type UserServiceErrors =
  | { code: "USER_NOT_FOUND"; message: string }
  | { code: "EMAIL_ALREADY_EXISTS"; message: string };

export interface GetUserInput {
  id: number;
}

export interface CreateUserInput {
  email: string;
  firebaseUid: string;
}

export interface UserService {
  getUserById(input: GetUserInput): Promise<Result<User, UserServiceErrors>>;
  createUser(input: CreateUserInput): Promise<Result<User, UserServiceErrors>>;
  getUsers(): Promise<Result<User[], DomainError>>;
  getUserByFirebaseUid(
    firebaseUid: string,
  ): Promise<Result<User, UserServiceErrors>>;
  createUserWithFirebase(
    input: CreateUserInput,
  ): Promise<Result<User, UserServiceErrors>>;
}

export function createUserService(repository: UserRepository): UserService {
  return {
    async getUserById(
      input: GetUserInput,
    ): Promise<Result<User, UserServiceErrors>> {
      const user = await repository.findById(input.id);
      if (!user) {
        return err({
          code: "USER_NOT_FOUND",
          message: `User with id ${input.id} not found`,
        });
      }
      return ok(user);
    },

    async createUser(
      input: CreateUserInput,
    ): Promise<Result<User, UserServiceErrors>> {
      const existingUser = await repository.findByEmail(input.email);
      if (existingUser) {
        return err({
          code: "EMAIL_ALREADY_EXISTS",
          message: `Email ${input.email} is already registered`,
        });
      }
      const user = await repository.create({
        email: input.email,
        firebaseUid: input.firebaseUid,
      });
      return ok(user);
    },

    async getUsers(): Promise<Result<User[], DomainError>> {
      const users = await repository.findMany({});
      return ok(users);
    },

    async getUserByFirebaseUid(
      firebaseUid: string,
    ): Promise<Result<User, UserServiceErrors>> {
      const user = await repository.findByFirebaseUid(firebaseUid);
      if (!user) {
        return err({
          code: "USER_NOT_FOUND",
          message: `User with Firebase UID ${firebaseUid} not found`,
        });
      }
      return ok(user);
    },

    async createUserWithFirebase(
      input: CreateUserInput,
    ): Promise<Result<User, UserServiceErrors>> {
      const existingUser = await repository.findByEmail(input.email);
      if (existingUser) {
        return err({
          code: "EMAIL_ALREADY_EXISTS",
          message: `Email ${input.email} is already registered`,
        });
      }
      const user = await repository.create({
        email: input.email,
        firebaseUid: input.firebaseUid,
      });
      return ok(user);
    },
  };
}
