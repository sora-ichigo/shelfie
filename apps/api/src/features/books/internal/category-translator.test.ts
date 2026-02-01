import { describe, expect, it } from "vitest";
import {
  resolveRakutenGenreName,
  resolveRakutenGenreNames,
  translateGoogleCategories,
  translateGoogleCategory,
} from "./category-translator.js";

describe("category-translator", () => {
  describe("translateGoogleCategory", () => {
    it("単一カテゴリを翻訳する", () => {
      expect(translateGoogleCategory("Fiction")).toBe("小説");
    });

    it("階層カテゴリの末尾を優先する", () => {
      expect(translateGoogleCategory("Comics & Graphic Novels / Manga")).toBe(
        "マンガ",
      );
    });

    it("末尾が未知の場合は親を試す", () => {
      expect(
        translateGoogleCategory("Comics & Graphic Novels / Unknown Sub"),
      ).toBe("コミック");
    });

    it("翻訳不可の場合は null を返す", () => {
      expect(translateGoogleCategory("Totally Unknown Category")).toBeNull();
    });
  });

  describe("translateGoogleCategories", () => {
    it("翻訳可能なカテゴリのみ返す", () => {
      expect(
        translateGoogleCategories(["Fiction", "Unknown", "Drama"]),
      ).toEqual(["小説", "ドラマ"]);
    });

    it("重複を除去する", () => {
      expect(
        translateGoogleCategories([
          "Comics & Graphic Novels / Manga",
          "Comics & Graphic Novels",
          "Manga",
        ]),
      ).toEqual(["マンガ", "コミック"]);
    });

    it("全て翻訳不可の場合は空配列を返す", () => {
      expect(translateGoogleCategories(["Unknown1", "Unknown2"])).toEqual([]);
    });

    it("空配列を渡すと空配列を返す", () => {
      expect(translateGoogleCategories([])).toEqual([]);
    });
  });

  describe("resolveRakutenGenreName", () => {
    it("第3階層の既知IDを解決する", () => {
      expect(resolveRakutenGenreName("001001001")).toBe("少年コミック");
    });

    it("第2階層の既知IDを解決する", () => {
      expect(resolveRakutenGenreName("001001")).toBe("コミック");
    });

    it("未知の第3階層IDは親階層にフォールバックする", () => {
      expect(resolveRakutenGenreName("001004099")).toBe("ライトノベル");
    });

    it("完全に未知のIDは null を返す", () => {
      expect(resolveRakutenGenreName("999999999")).toBeNull();
    });
  });

  describe("resolveRakutenGenreNames", () => {
    it("スラッシュ区切りの複数ジャンルIDを解決する", () => {
      const result = resolveRakutenGenreNames("001001001/001004008");
      expect(result).toEqual(["少年コミック", "ライトノベル(男性向け)"]);
    });

    it("重複を除去する", () => {
      const result = resolveRakutenGenreNames("001001001/001001001");
      expect(result).toEqual(["少年コミック"]);
    });

    it("空文字列は空配列を返す", () => {
      expect(resolveRakutenGenreNames("")).toEqual([]);
    });

    it("全て未知のIDの場合は空配列を返す", () => {
      expect(resolveRakutenGenreNames("999999/888888")).toEqual([]);
    });
  });
});
