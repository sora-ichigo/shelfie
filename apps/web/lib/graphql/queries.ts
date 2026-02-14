import { graphql } from "./generated";

export const UserByHandleQuery = graphql(`
  query UserByHandle($handle: String!) {
    userByHandle(handle: $handle) {
      ...UserProfilePage_User
    }
  }
`);
