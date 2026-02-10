import { describe, expect, it, vi } from "vitest";
import { createFCMAdapter } from "./fcm-adapter.js";

function createMockMessaging() {
  return {
    sendEachForMulticast: vi.fn(),
  };
}

describe("FCMAdapter", () => {
  describe("interface compliance", () => {
    it("should implement sendMulticast method", () => {
      const mockMessaging = createMockMessaging();
      const adapter = createFCMAdapter(mockMessaging as never);

      expect(typeof adapter.sendMulticast).toBe("function");
    });
  });

  describe("sendMulticast", () => {
    it("should return success result when all tokens succeed", async () => {
      const mockMessaging = createMockMessaging();
      mockMessaging.sendEachForMulticast.mockResolvedValue({
        successCount: 2,
        failureCount: 0,
        responses: [{ success: true }, { success: true }],
      });

      const adapter = createFCMAdapter(mockMessaging as never);
      const result = await adapter.sendMulticast(["token-1", "token-2"], {
        title: "Test",
        body: "Hello",
      });

      expect(result.successCount).toBe(2);
      expect(result.failureCount).toBe(0);
      expect(result.responses).toHaveLength(2);
      expect(result.responses[0].success).toBe(true);
      expect(result.responses[0].token).toBe("token-1");
      expect(result.responses[1].token).toBe("token-2");
    });

    it("should return failure details when some tokens fail", async () => {
      const mockMessaging = createMockMessaging();
      mockMessaging.sendEachForMulticast.mockResolvedValue({
        successCount: 1,
        failureCount: 1,
        responses: [
          { success: true },
          {
            success: false,
            error: {
              code: "messaging/registration-token-not-registered",
              message: "Token not registered",
            },
          },
        ],
      });

      const adapter = createFCMAdapter(mockMessaging as never);
      const result = await adapter.sendMulticast(
        ["token-valid", "token-invalid"],
        { title: "Test", body: "Hello" },
      );

      expect(result.successCount).toBe(1);
      expect(result.failureCount).toBe(1);
      expect(result.responses[0].success).toBe(true);
      expect(result.responses[0].token).toBe("token-valid");
      expect(result.responses[1].success).toBe(false);
      expect(result.responses[1].token).toBe("token-invalid");
      expect(result.responses[1].error?.code).toBe(
        "messaging/registration-token-not-registered",
      );
    });

    it("should call sendEachForMulticast with correct parameters", async () => {
      const mockMessaging = createMockMessaging();
      mockMessaging.sendEachForMulticast.mockResolvedValue({
        successCount: 1,
        failureCount: 0,
        responses: [{ success: true }],
      });

      const adapter = createFCMAdapter(mockMessaging as never);
      await adapter.sendMulticast(["token-1"], {
        title: "My Title",
        body: "My Body",
      });

      expect(mockMessaging.sendEachForMulticast).toHaveBeenCalledWith({
        tokens: ["token-1"],
        notification: { title: "My Title", body: "My Body" },
      });
    });

    it("should pass data parameter to sendEachForMulticast", async () => {
      const mockMessaging = createMockMessaging();
      mockMessaging.sendEachForMulticast.mockResolvedValue({
        successCount: 1,
        failureCount: 0,
        responses: [{ success: true }],
      });

      const adapter = createFCMAdapter(mockMessaging as never);
      await adapter.sendMulticast(
        ["token-1"],
        { title: "My Title", body: "My Body" },
        { route: "/books/123?source=rakuten" },
      );

      expect(mockMessaging.sendEachForMulticast).toHaveBeenCalledWith({
        tokens: ["token-1"],
        notification: { title: "My Title", body: "My Body" },
        data: { route: "/books/123?source=rakuten" },
      });
    });

    it("should not include data when not provided", async () => {
      const mockMessaging = createMockMessaging();
      mockMessaging.sendEachForMulticast.mockResolvedValue({
        successCount: 1,
        failureCount: 0,
        responses: [{ success: true }],
      });

      const adapter = createFCMAdapter(mockMessaging as never);
      await adapter.sendMulticast(["token-1"], {
        title: "My Title",
        body: "My Body",
      });

      expect(mockMessaging.sendEachForMulticast).toHaveBeenCalledWith({
        tokens: ["token-1"],
        notification: { title: "My Title", body: "My Body" },
      });
    });
  });
});
