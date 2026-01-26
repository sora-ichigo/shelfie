import { describe, expect, it } from "vitest";
import { transformImageKitUrl } from "./imagekit-url-transformer.js";

describe("transformImageKitUrl", () => {
  const sampleImageKitUrl = "https://ik.imagekit.io/demo/sample-avatar.jpg";

  it("returns null for null input", () => {
    expect(transformImageKitUrl(null)).toBeNull();
  });

  it("returns null for undefined input", () => {
    expect(transformImageKitUrl(undefined)).toBeNull();
  });

  it("returns original URL for non-ImageKit URLs", () => {
    const nonImageKitUrl = "https://example.com/avatar.jpg";
    expect(transformImageKitUrl(nonImageKitUrl)).toBe(nonImageKitUrl);
  });

  it("adds default 256x256 transformation to ImageKit URL", () => {
    const result = transformImageKitUrl(sampleImageKitUrl);
    expect(result).toBe(
      "https://ik.imagekit.io/demo/sample-avatar.jpg?tr=w-256,h-256,cm-pad_resize,bg-FFFFFF,q-90,f-auto",
    );
  });

  it("uses custom width and height when specified", () => {
    const result = transformImageKitUrl(sampleImageKitUrl, {
      width: 256,
      height: 256,
    });
    expect(result).toBe(
      "https://ik.imagekit.io/demo/sample-avatar.jpg?tr=w-256,h-256,cm-pad_resize,bg-FFFFFF,q-90,f-auto",
    );
  });

  it("replaces existing query parameters", () => {
    const urlWithParams =
      "https://ik.imagekit.io/demo/sample-avatar.jpg?existing=param";
    const result = transformImageKitUrl(urlWithParams);
    expect(result).toBe(
      "https://ik.imagekit.io/demo/sample-avatar.jpg?tr=w-256,h-256,cm-pad_resize,bg-FFFFFF,q-90,f-auto",
    );
  });

  it("handles invalid URLs gracefully", () => {
    const invalidUrl = "not-a-valid-url";
    expect(transformImageKitUrl(invalidUrl)).toBe(invalidUrl);
  });
});
