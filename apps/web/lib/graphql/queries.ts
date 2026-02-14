import { gql } from "@apollo/client";

export interface UserByHandleVars {
  handle: string;
}

export interface UserByHandleData {
  userByHandle: {
    name: string | null;
    avatarUrl: string | null;
    bio: string | null;
    handle: string | null;
  } | null;
}

export const USER_BY_HANDLE_QUERY = gql`
  query UserByHandle($handle: String!) {
    userByHandle(handle: $handle) {
      name
      avatarUrl
      bio
      handle
    }
  }
`;
