import { describe, expect, it } from "vitest";
import { parseNotificationArgs } from "./parse-notification-args.js";

describe("parseNotificationArgs", () => {
  it("should parse --title, --body, and --all correctly", () => {
    const result = parseNotificationArgs([
      "--title",
      "Test Title",
      "--body",
      "Test Body",
      "--all",
    ]);

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.title).toBe("Test Title");
      expect(result.data.body).toBe("Test Body");
      expect(result.data.userIds).toBe("all");
    }
  });

  it("should parse --title, --body, and --user-ids correctly", () => {
    const result = parseNotificationArgs([
      "--title",
      "Test Title",
      "--body",
      "Test Body",
      "--user-ids",
      "1,2,3",
    ]);

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.title).toBe("Test Title");
      expect(result.data.body).toBe("Test Body");
      expect(result.data.userIds).toEqual([1, 2, 3]);
    }
  });

  it("should return error when --title is missing", () => {
    const result = parseNotificationArgs(["--body", "Test Body", "--all"]);

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toContain("--title");
    }
  });

  it("should return error when --body is missing", () => {
    const result = parseNotificationArgs(["--title", "Test Title", "--all"]);

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toContain("--body");
    }
  });

  it("should return error when neither --all nor --user-ids is specified", () => {
    const result = parseNotificationArgs([
      "--title",
      "Test Title",
      "--body",
      "Test Body",
    ]);

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toContain("--all");
      expect(result.error).toContain("--user-ids");
    }
  });

  it("should return error when both --all and --user-ids are specified", () => {
    const result = parseNotificationArgs([
      "--title",
      "Test Title",
      "--body",
      "Test Body",
      "--all",
      "--user-ids",
      "1,2",
    ]);

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toContain("--all");
      expect(result.error).toContain("--user-ids");
    }
  });

  it("should return error for invalid user-ids format", () => {
    const result = parseNotificationArgs([
      "--title",
      "Test Title",
      "--body",
      "Test Body",
      "--user-ids",
      "1,abc,3",
    ]);

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toContain("user-ids");
    }
  });
});
