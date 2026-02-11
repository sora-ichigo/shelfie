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
  | { code: "EMAIL_ALREADY_EXISTS"; message: string }
  | { code: "VALIDATION_ERROR"; message: string };

export interface GetUserInput {
  id: number;
}

export interface CreateUserInput {
  email: string;
  firebaseUid: string;
}

export interface UpdateProfileInput {
  userId: number;
  name: string;
  avatarUrl?: string;
  bio?: string;
  instagramHandle?: string;
}

export interface DeleteAccountInput {
  id: number;
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
  updateProfile(
    input: UpdateProfileInput,
  ): Promise<Result<User, UserServiceErrors>>;
  deleteAccount(
    input: DeleteAccountInput,
  ): Promise<Result<void, UserServiceErrors>>;
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

    async updateProfile(
      input: UpdateProfileInput,
    ): Promise<Result<User, UserServiceErrors>> {
      const trimmedName = input.name.trim();
      if (trimmedName === "") {
        return err({
          code: "VALIDATION_ERROR",
          message: "氏名は空にできません",
        });
      }

      if (input.bio !== undefined && input.bio.length > 500) {
        return err({
          code: "VALIDATION_ERROR",
          message: "自己紹介は500文字以内で入力してください",
        });
      }

      const user = await repository.findById(input.userId);
      if (!user) {
        return err({
          code: "USER_NOT_FOUND",
          message: `User with id ${input.userId} not found`,
        });
      }

      const updateData: Partial<User> = { name: trimmedName };
      if (input.avatarUrl !== undefined) {
        updateData.avatarUrl = input.avatarUrl;
      }
      if (input.bio !== undefined) {
        updateData.bio = input.bio;
      }
      if (input.instagramHandle !== undefined) {
        updateData.instagramHandle = input.instagramHandle;
      }

      const updatedUser = await repository.update(input.userId, updateData);
      return ok(updatedUser);
    },

    async deleteAccount(
      input: DeleteAccountInput,
    ): Promise<Result<void, UserServiceErrors>> {
      const user = await repository.findById(input.id);
      if (!user) {
        return err({
          code: "USER_NOT_FOUND",
          message: `User with id ${input.id} not found`,
        });
      }

      await repository.delete(input.id);
      return ok(undefined);
    },
  };
}
