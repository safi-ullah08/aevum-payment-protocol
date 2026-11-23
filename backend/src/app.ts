import Fastify, { type FastifyInstance } from 'fastify';
import type { Env } from './config/env.js';
import { NotImplementedError } from './errors.js';
import { x402Routes } from './x402/routes.js';

export async function buildApp(env: Env): Promise<FastifyInstance> {
  const app = Fastify({ logger: env.NODE_ENV !== 'test' });

  app.setErrorHandler((error, _request, reply) => {
    if (error instanceof NotImplementedError) {
      return reply.code(501).send({ error: 'Not Implemented', message: error.message });
    }
    return reply.send(error);
  });

  app.get('/health', async () => ({ ok: true, chainId: env.AEVUM_CHAIN_ID }));
  await app.register(x402Routes, { env });

  return app;
}
