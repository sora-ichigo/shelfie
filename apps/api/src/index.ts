import { startServer } from "./graphql/server";

const port = Number(process.env.PORT) || 4000;

startServer(port).catch(console.error);
