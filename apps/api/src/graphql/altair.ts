import { altairExpress } from "altair-express-middleware";

const autoSetTokenScript = `
const data = altair.response.body?.data;
if (data?.loginUser?.idToken) {
  altair.helpers.setEnvironment('token', data.loginUser.idToken);
} else if (data?.refreshToken?.idToken) {
  altair.helpers.setEnvironment('token', data.refreshToken.idToken);
}
`.trim();

export function createAltairMiddleware() {
  return altairExpress({
    endpointURL: "/graphql",
    initialName: "Shelfie API",
    initialEnvironments: {
      base: {
        title: "Dev",
        variables: { token: "" },
      },
      subEnvironments: [],
    },
    initialHeaders: {
      Authorization: "Bearer {{token}}",
    },
    initialPostRequestScript: autoSetTokenScript,
  });
}
