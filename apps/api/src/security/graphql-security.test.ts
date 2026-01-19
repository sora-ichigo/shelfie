import { describe, expect, it } from "vitest";
import {
  type DepthLimitConfig,
  calculateQueryCost,
  createDepthLimitRule,
  DEFAULT_DEPTH_LIMIT,
  type QueryCostAnalysis,
} from "./graphql-security";

describe("GraphQL Security", () => {
  describe("createDepthLimitRule", () => {
    it("デフォルトの深度制限値を返す", () => {
      const rule = createDepthLimitRule();
      expect(rule.maxDepth).toBe(DEFAULT_DEPTH_LIMIT);
    });

    it("カスタムの深度制限値を設定できる", () => {
      const customConfig: DepthLimitConfig = { maxDepth: 15 };
      const rule = createDepthLimitRule(customConfig);
      expect(rule.maxDepth).toBe(15);
    });

    it("深度制限のルール名を持つ", () => {
      const rule = createDepthLimitRule();
      expect(rule.name).toBe("DepthLimit");
    });
  });

  describe("calculateQueryCost", () => {
    it("シンプルなクエリのコストを計算する", () => {
      const analysis: QueryCostAnalysis = {
        fields: 3,
        depth: 2,
        complexity: 1,
      };
      const cost = calculateQueryCost(analysis);
      expect(cost).toBe(3 * 1 + 2 * 2 + 1 * 5);
    });

    it("複雑なクエリのコストを計算する", () => {
      const analysis: QueryCostAnalysis = {
        fields: 10,
        depth: 5,
        complexity: 3,
      };
      const cost = calculateQueryCost(analysis);
      expect(cost).toBe(10 * 1 + 5 * 2 + 3 * 5);
    });

    it("空のクエリのコストは 0", () => {
      const analysis: QueryCostAnalysis = {
        fields: 0,
        depth: 0,
        complexity: 0,
      };
      const cost = calculateQueryCost(analysis);
      expect(cost).toBe(0);
    });
  });
});
