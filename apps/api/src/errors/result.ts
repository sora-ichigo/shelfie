export interface DomainError {
  code: string;
  message: string;
}

export type Result<T, E extends DomainError = DomainError> =
  | { success: true; data: T }
  | { success: false; error: E };

export function ok<T>(data: T): Result<T, never> {
  return { success: true, data };
}

export function err<T = never, E extends DomainError = DomainError>(
  error: E,
): Result<T, E> {
  return { success: false, error };
}

export function isOk<T, E extends DomainError>(
  result: Result<T, E>,
): result is { success: true; data: T } {
  return result.success;
}

export function isErr<T, E extends DomainError>(
  result: Result<T, E>,
): result is { success: false; error: E } {
  return !result.success;
}

export function unwrap<T, E extends DomainError>(result: Result<T, E>): T {
  if (result.success) {
    return result.data;
  }
  throw new Error(`${result.error.code}: ${result.error.message}`);
}

export function unwrapOr<T, E extends DomainError>(
  result: Result<T, E>,
  defaultValue: T,
): T {
  if (result.success) {
    return result.data;
  }
  return defaultValue;
}

export function mapResult<T, U, E extends DomainError>(
  result: Result<T, E>,
  fn: (data: T) => U,
): Result<U, E> {
  if (result.success) {
    return ok(fn(result.data));
  }
  return result;
}

export function mapErr<T, E extends DomainError, F extends DomainError>(
  result: Result<T, E>,
  fn: (error: E) => F,
): Result<T, F> {
  if (result.success) {
    return result;
  }
  return err(fn(result.error));
}
