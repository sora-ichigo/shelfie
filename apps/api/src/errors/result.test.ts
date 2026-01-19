import { describe, expect, it } from "vitest";
import {
  type DomainError,
  err,
  isErr,
  isOk,
  mapErr,
  mapResult,
  ok,
  type Result,
  unwrap,
  unwrapOr,
} from "./result";

describe("Result type", () => {
  describe("ok", () => {
    it("should create a success result", () => {
      const result = ok(42);

      expect(result.success).toBe(true);
      expect(isOk(result)).toBe(true);
      expect(isErr(result)).toBe(false);
    });

    it("should store the data value", () => {
      const result = ok({ name: "test" });

      if (result.success) {
        expect(result.data).toEqual({ name: "test" });
      }
    });
  });

  describe("err", () => {
    it("should create an error result", () => {
      const error: DomainError = {
        code: "NOT_FOUND",
        message: "Resource not found",
      };
      const result = err(error);

      expect(result.success).toBe(false);
      expect(isOk(result)).toBe(false);
      expect(isErr(result)).toBe(true);
    });

    it("should store the error value", () => {
      const error: DomainError = {
        code: "VALIDATION_ERROR",
        message: "Invalid input",
      };
      const result = err(error);

      if (!result.success) {
        expect(result.error).toEqual(error);
      }
    });
  });

  describe("type guards", () => {
    it("isOk should narrow type to success result", () => {
      const result: Result<number, DomainError> = ok(42);

      if (isOk(result)) {
        const data: number = result.data;
        expect(data).toBe(42);
      }
    });

    it("isErr should narrow type to error result", () => {
      const error: DomainError = { code: "ERROR", message: "test" };
      const result: Result<number, DomainError> = err(error);

      if (isErr(result)) {
        const errorValue: DomainError = result.error;
        expect(errorValue.code).toBe("ERROR");
      }
    });
  });

  describe("unwrap", () => {
    it("should return data for success result", () => {
      const result = ok(42);
      expect(unwrap(result)).toBe(42);
    });

    it("should throw for error result", () => {
      const error: DomainError = { code: "ERROR", message: "test" };
      const result = err(error);

      expect(() => unwrap(result)).toThrow("ERROR: test");
    });
  });

  describe("unwrapOr", () => {
    it("should return data for success result", () => {
      const result = ok(42);
      expect(unwrapOr(result, 0)).toBe(42);
    });

    it("should return default value for error result", () => {
      const error: DomainError = { code: "ERROR", message: "test" };
      const result = err<number, DomainError>(error);

      expect(unwrapOr(result, 0)).toBe(0);
    });
  });

  describe("mapResult", () => {
    it("should transform data for success result", () => {
      const result = ok(42);
      const mapped = mapResult(result, (n) => n * 2);

      expect(isOk(mapped)).toBe(true);
      if (isOk(mapped)) {
        expect(mapped.data).toBe(84);
      }
    });

    it("should pass through error for error result", () => {
      const error: DomainError = { code: "ERROR", message: "test" };
      const result = err<number, DomainError>(error);
      const mapped = mapResult(result, (n) => n * 2);

      expect(isErr(mapped)).toBe(true);
      if (isErr(mapped)) {
        expect(mapped.error).toEqual(error);
      }
    });
  });

  describe("mapErr", () => {
    it("should pass through data for success result", () => {
      const result: Result<number, DomainError> = ok(42);
      const mapped = mapErr(result, (e) => ({
        code: `MAPPED_${e.code}`,
        message: e.message,
      }));

      expect(isOk(mapped)).toBe(true);
      if (isOk(mapped)) {
        expect(mapped.data).toBe(42);
      }
    });

    it("should transform error for error result", () => {
      const error: DomainError = { code: "ERROR", message: "test" };
      const result = err<number, DomainError>(error);
      const mapped = mapErr(result, (e) => ({
        code: `MAPPED_${e.code}`,
        message: e.message,
      }));

      expect(isErr(mapped)).toBe(true);
      if (isErr(mapped)) {
        expect(mapped.error.code).toBe("MAPPED_ERROR");
      }
    });
  });
});

describe("DomainError", () => {
  it("should have code and message properties", () => {
    const error: DomainError = {
      code: "USER_NOT_FOUND",
      message: "User with given ID was not found",
    };

    expect(error.code).toBe("USER_NOT_FOUND");
    expect(error.message).toBe("User with given ID was not found");
  });
});

describe("Service layer usage pattern", () => {
  interface User {
    id: string;
    email: string;
  }

  interface UserNotFoundError extends DomainError {
    code: "USER_NOT_FOUND";
    userId: string;
  }

  interface InvalidEmailError extends DomainError {
    code: "INVALID_EMAIL";
    email: string;
  }

  const findUser = (id: string): Result<User, UserNotFoundError> => {
    if (id === "existing") {
      return ok({ id: "existing", email: "test@example.com" });
    }
    return err({
      code: "USER_NOT_FOUND",
      message: `User ${id} not found`,
      userId: id,
    });
  };

  const validateEmail = (email: string): Result<string, InvalidEmailError> => {
    if (email.includes("@")) {
      return ok(email);
    }
    return err({
      code: "INVALID_EMAIL",
      message: `Invalid email format: ${email}`,
      email,
    });
  };

  it("should handle success case in service", () => {
    const result = findUser("existing");

    expect(isOk(result)).toBe(true);
    if (isOk(result)) {
      expect(result.data.email).toBe("test@example.com");
    }
  });

  it("should handle error case in service", () => {
    const result = findUser("non-existing");

    expect(isErr(result)).toBe(true);
    if (isErr(result)) {
      expect(result.error.code).toBe("USER_NOT_FOUND");
      expect(result.error.userId).toBe("non-existing");
    }
  });

  it("should support extending DomainError with additional fields", () => {
    const result = validateEmail("invalid-email");

    expect(isErr(result)).toBe(true);
    if (isErr(result)) {
      expect(result.error.code).toBe("INVALID_EMAIL");
      expect(result.error.email).toBe("invalid-email");
    }
  });

  it("should support chaining operations with mapResult", () => {
    const result = findUser("existing");
    const uppercaseEmail = mapResult(result, (user) =>
      user.email.toUpperCase(),
    );

    expect(isOk(uppercaseEmail)).toBe(true);
    if (isOk(uppercaseEmail)) {
      expect(uppercaseEmail.data).toBe("TEST@EXAMPLE.COM");
    }
  });
});
