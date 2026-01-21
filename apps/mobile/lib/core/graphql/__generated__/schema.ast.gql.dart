// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gql/ast.dart' as _i1;

const AuthError = _i1.ObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'AuthError'),
  directives: [],
  interfaces: [],
  fields: [
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'code'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'AuthErrorCode'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'field'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'message'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'retryable'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'Boolean'),
        isNonNull: false,
      ),
    ),
  ],
);
const AuthErrorCode = _i1.EnumTypeDefinitionNode(
  name: _i1.NameNode(value: 'AuthErrorCode'),
  directives: [],
  values: [
    _i1.EnumValueDefinitionNode(
      name: _i1.NameNode(value: 'EMAIL_ALREADY_EXISTS'),
      directives: [],
    ),
    _i1.EnumValueDefinitionNode(
      name: _i1.NameNode(value: 'INTERNAL_ERROR'),
      directives: [],
    ),
    _i1.EnumValueDefinitionNode(
      name: _i1.NameNode(value: 'INVALID_CREDENTIALS'),
      directives: [],
    ),
    _i1.EnumValueDefinitionNode(
      name: _i1.NameNode(value: 'INVALID_PASSWORD'),
      directives: [],
    ),
    _i1.EnumValueDefinitionNode(
      name: _i1.NameNode(value: 'INVALID_TOKEN'),
      directives: [],
    ),
    _i1.EnumValueDefinitionNode(
      name: _i1.NameNode(value: 'NETWORK_ERROR'),
      directives: [],
    ),
    _i1.EnumValueDefinitionNode(
      name: _i1.NameNode(value: 'TOKEN_EXPIRED'),
      directives: [],
    ),
    _i1.EnumValueDefinitionNode(
      name: _i1.NameNode(value: 'UNAUTHENTICATED'),
      directives: [],
    ),
    _i1.EnumValueDefinitionNode(
      name: _i1.NameNode(value: 'USER_NOT_FOUND'),
      directives: [],
    ),
  ],
);
const AuthErrorResult = _i1.ObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'AuthErrorResult'),
  directives: [],
  interfaces: [],
  fields: [
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'code'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'AuthErrorCode'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'field'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'message'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'retryable'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'Boolean'),
        isNonNull: false,
      ),
    ),
  ],
);
const DateTime = _i1.ScalarTypeDefinitionNode(
  name: _i1.NameNode(value: 'DateTime'),
  directives: [],
);
const LoginResult = _i1.ObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'LoginResult'),
  directives: [],
  interfaces: [],
  fields: [
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'idToken'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'user'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'User'),
        isNonNull: true,
      ),
    ),
  ],
);
const LoginUserInput = _i1.InputObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'LoginUserInput'),
  directives: [],
  fields: [
    _i1.InputValueDefinitionNode(
      name: _i1.NameNode(value: 'email'),
      directives: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
      defaultValue: null,
    ),
    _i1.InputValueDefinitionNode(
      name: _i1.NameNode(value: 'password'),
      directives: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
      defaultValue: null,
    ),
  ],
);
const MeResult = _i1.UnionTypeDefinitionNode(
  name: _i1.NameNode(value: 'MeResult'),
  directives: [],
  types: [
    _i1.NamedTypeNode(
      name: _i1.NameNode(value: 'AuthErrorResult'),
      isNonNull: false,
    ),
    _i1.NamedTypeNode(
      name: _i1.NameNode(value: 'User'),
      isNonNull: false,
    ),
  ],
);
const Mutation = _i1.ObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'Mutation'),
  directives: [],
  interfaces: [],
  fields: [
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'loginUser'),
      directives: [],
      args: [
        _i1.InputValueDefinitionNode(
          name: _i1.NameNode(value: 'input'),
          directives: [],
          type: _i1.NamedTypeNode(
            name: _i1.NameNode(value: 'LoginUserInput'),
            isNonNull: true,
          ),
          defaultValue: null,
        )
      ],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'MutationLoginUserResult'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'registerUser'),
      directives: [],
      args: [
        _i1.InputValueDefinitionNode(
          name: _i1.NameNode(value: 'input'),
          directives: [],
          type: _i1.NamedTypeNode(
            name: _i1.NameNode(value: 'RegisterUserInput'),
            isNonNull: true,
          ),
          defaultValue: null,
        )
      ],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'MutationRegisterUserResult'),
        isNonNull: false,
      ),
    ),
  ],
);
const MutationLoginUserResult = _i1.UnionTypeDefinitionNode(
  name: _i1.NameNode(value: 'MutationLoginUserResult'),
  directives: [],
  types: [
    _i1.NamedTypeNode(
      name: _i1.NameNode(value: 'AuthError'),
      isNonNull: false,
    ),
    _i1.NamedTypeNode(
      name: _i1.NameNode(value: 'MutationLoginUserSuccess'),
      isNonNull: false,
    ),
  ],
);
const MutationLoginUserSuccess = _i1.ObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'MutationLoginUserSuccess'),
  directives: [],
  interfaces: [],
  fields: [
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'data'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'LoginResult'),
        isNonNull: true,
      ),
    )
  ],
);
const MutationRegisterUserResult = _i1.UnionTypeDefinitionNode(
  name: _i1.NameNode(value: 'MutationRegisterUserResult'),
  directives: [],
  types: [
    _i1.NamedTypeNode(
      name: _i1.NameNode(value: 'AuthError'),
      isNonNull: false,
    ),
    _i1.NamedTypeNode(
      name: _i1.NameNode(value: 'MutationRegisterUserSuccess'),
      isNonNull: false,
    ),
  ],
);
const MutationRegisterUserSuccess = _i1.ObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'MutationRegisterUserSuccess'),
  directives: [],
  interfaces: [],
  fields: [
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'data'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'User'),
        isNonNull: true,
      ),
    )
  ],
);
const Query = _i1.ObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'Query'),
  directives: [],
  interfaces: [],
  fields: [
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'health'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'me'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'MeResult'),
        isNonNull: true,
      ),
    ),
  ],
);
const RegisterUserInput = _i1.InputObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'RegisterUserInput'),
  directives: [],
  fields: [
    _i1.InputValueDefinitionNode(
      name: _i1.NameNode(value: 'email'),
      directives: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
      defaultValue: null,
    ),
    _i1.InputValueDefinitionNode(
      name: _i1.NameNode(value: 'password'),
      directives: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
      defaultValue: null,
    ),
  ],
);
const User = _i1.ObjectTypeDefinitionNode(
  name: _i1.NameNode(value: 'User'),
  directives: [],
  interfaces: [],
  fields: [
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'createdAt'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'DateTime'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'email'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'id'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'Int'),
        isNonNull: false,
      ),
    ),
    _i1.FieldDefinitionNode(
      name: _i1.NameNode(value: 'updatedAt'),
      directives: [],
      args: [],
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'DateTime'),
        isNonNull: false,
      ),
    ),
  ],
);
const document = _i1.DocumentNode(definitions: [
  AuthError,
  AuthErrorCode,
  AuthErrorResult,
  DateTime,
  LoginResult,
  LoginUserInput,
  MeResult,
  Mutation,
  MutationLoginUserResult,
  MutationLoginUserSuccess,
  MutationRegisterUserResult,
  MutationRegisterUserSuccess,
  Query,
  RegisterUserInput,
  User,
]);
