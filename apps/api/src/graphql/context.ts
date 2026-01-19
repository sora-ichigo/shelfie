import type { AuthenticatedUser } from "../auth";

export interface GraphQLContext {
  requestId: string;
  user: AuthenticatedUser | null;
}
