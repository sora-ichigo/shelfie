export const DEFAULT_DEPTH_LIMIT = 10;

export interface DepthLimitConfig {
  maxDepth: number;
}

export interface DepthLimitRule {
  name: string;
  maxDepth: number;
}

export function createDepthLimitRule(
  config?: DepthLimitConfig,
): DepthLimitRule {
  return {
    name: "DepthLimit",
    maxDepth: config?.maxDepth ?? DEFAULT_DEPTH_LIMIT,
  };
}

export interface QueryCostAnalysis {
  fields: number;
  depth: number;
  complexity: number;
}

const FIELD_COST = 1;
const DEPTH_COST = 2;
const COMPLEXITY_COST = 5;

export function calculateQueryCost(analysis: QueryCostAnalysis): number {
  return (
    analysis.fields * FIELD_COST +
    analysis.depth * DEPTH_COST +
    analysis.complexity * COMPLEXITY_COST
  );
}
