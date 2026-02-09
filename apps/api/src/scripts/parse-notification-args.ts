import { parseArgs } from "node:util";

export interface ParsedNotificationArgs {
  title: string;
  body: string;
  userIds: number[] | "all";
}

type ParseResult =
  | { success: true; data: ParsedNotificationArgs }
  | { success: false; error: string };

export function parseNotificationArgs(args: string[]): ParseResult {
  let parsed: ReturnType<typeof parseArgs>;
  try {
    parsed = parseArgs({
      args,
      options: {
        title: { type: "string" },
        body: { type: "string" },
        all: { type: "boolean", default: false },
        "user-ids": { type: "string" },
      },
      strict: true,
    });
  } catch {
    return {
      success: false,
      error: "Invalid arguments. Usage: --title <string> --body <string> (--all | --user-ids <id1,id2,...>)",
    };
  }

  const { title, body, all, "user-ids": userIdsStr } = parsed.values;

  if (!title) {
    return {
      success: false,
      error: "--title is required",
    };
  }

  if (!body) {
    return {
      success: false,
      error: "--body is required",
    };
  }

  if (all && userIdsStr) {
    return {
      success: false,
      error: "--all and --user-ids cannot be specified at the same time",
    };
  }

  if (!all && !userIdsStr) {
    return {
      success: false,
      error: "Either --all or --user-ids must be specified",
    };
  }

  if (all) {
    return {
      success: true,
      data: { title, body, userIds: "all" },
    };
  }

  const userIdStrings = userIdsStr!.split(",").map((s) => s.trim());
  const userIds = userIdStrings.map(Number);

  if (userIds.some(Number.isNaN)) {
    return {
      success: false,
      error: "Invalid user-ids: all values must be numeric",
    };
  }

  return {
    success: true,
    data: { title, body, userIds },
  };
}
