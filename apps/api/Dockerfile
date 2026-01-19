# syntax=docker/dockerfile:1

# =============================================================================
# Base Stage: Node.js 24 slim with corepack enabled
# =============================================================================
FROM node:24-slim AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app

# =============================================================================
# Dependencies Stage: Install all dependencies
# =============================================================================
FROM base AS deps

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/api/package.json ./apps/api/
COPY packages/shared/package.json ./packages/shared/

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile

# =============================================================================
# Build Stage: Build the application
# =============================================================================
FROM deps AS build

COPY apps/api ./apps/api
COPY packages/shared ./packages/shared
COPY tsconfig.base.json ./

RUN pnpm --filter @shelfie/shared build
RUN pnpm --filter @shelfie/api build

# =============================================================================
# Production Stage: Minimal runtime image
# =============================================================================
FROM base AS production

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/api/package.json ./apps/api/
COPY packages/shared/package.json ./packages/shared/

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile --prod

COPY --from=build /app/apps/api/dist ./apps/api/dist
COPY --from=build /app/packages/shared/dist ./packages/shared/dist

USER node

EXPOSE 4000

CMD ["node", "apps/api/dist/index.js"]
