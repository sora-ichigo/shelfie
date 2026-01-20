import { eq } from "drizzle-orm";
import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import { type NewUser, type User, users } from "../../../db/schema/users.js";

export type { NewUser, User } from "../../../db/schema/users.js";

export interface UserRepository {
  findById(id: number): Promise<User | null>;
  findByEmail(email: string): Promise<User | null>;
  findByFirebaseUid(firebaseUid: string): Promise<User | null>;
  findMany(filter: Partial<User>): Promise<User[]>;
  create(data: NewUser): Promise<User>;
  update(id: number, data: Partial<User>): Promise<User>;
  delete(id: number): Promise<void>;
}

export function createUserRepository(db: NodePgDatabase): UserRepository {
  return {
    async findById(id: number): Promise<User | null> {
      const result = await db.select().from(users).where(eq(users.id, id));
      return result[0] ?? null;
    },

    async findByEmail(email: string): Promise<User | null> {
      const result = await db
        .select()
        .from(users)
        .where(eq(users.email, email));
      return result[0] ?? null;
    },

    async findByFirebaseUid(firebaseUid: string): Promise<User | null> {
      const result = await db
        .select()
        .from(users)
        .where(eq(users.firebaseUid, firebaseUid));
      return result[0] ?? null;
    },

    async findMany(_filter: Partial<User>): Promise<User[]> {
      return db.select().from(users);
    },

    async create(data: NewUser): Promise<User> {
      const result = await db.insert(users).values(data).returning();
      return result[0];
    },

    async update(id: number, data: Partial<User>): Promise<User> {
      const result = await db
        .update(users)
        .set({ ...data, updatedAt: new Date() })
        .where(eq(users.id, id))
        .returning();
      return result[0];
    },

    async delete(id: number): Promise<void> {
      await db.delete(users).where(eq(users.id, id));
    },
  };
}
