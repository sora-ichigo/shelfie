import { getClient } from "./client";
import { UserByHandleQuery } from "./queries";

export async function fetchUserByHandle(handle: string) {
  try {
    const client = getClient();
    const { data } = await client.query({
      query: UserByHandleQuery,
      variables: { handle },
    });
    return data?.userByHandle ?? null;
  } catch {
    return null;
  }
}
