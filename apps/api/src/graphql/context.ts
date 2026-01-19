export interface DecodedUser {
  uid: string;
}

export interface GraphQLContext {
  requestId: string;
  user: DecodedUser | null;
}
