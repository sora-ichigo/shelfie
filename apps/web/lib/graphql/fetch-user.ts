import { getClient } from "./client.js";
import {
  USER_BY_HANDLE_QUERY,
  type UserByHandleData,
  type UserByHandleVars,
} from "./queries.js";

export async function fetchUserByHandle(handle: string) {
  try {
    const client = getClient();
    const { data } = await client.query<UserByHandleData, UserByHandleVars>({
      query: USER_BY_HANDLE_QUERY,
      variables: { handle },
    });
    return data?.userByHandle ?? null;
  } catch {
    return null;
  }
}
