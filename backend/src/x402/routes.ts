import { X_PAYMENT_HEADER } from '@aevum/shared';
import type { FastifyInstance } from 'fastify';
import type { Env } from '../config/env.js';
import { findResource } from './catalog.js';
import { paymentRequired, quote, settleBatch, verifyVoucher } from './gateway.js';

export async function x402Routes(app: FastifyInstance, opts: { env: Env }): Promise<void> {
  /**
   * GET /resource/:id
   * - No X-PAYMENT header: 402 with x402 PaymentRequirements built from the resource's plan.
   * - With X-PAYMENT header (paid retry): verify the voucher, then serve the resource.
   *   verifyVoucher is a stub, so the paid retry currently returns 501.
   */
  app.get<{ Params: { id: string } }>('/resource/:id', async (request, reply) => {
    const entry = findResource(request.params.id);
    if (!entry) return reply.code(404).send({ error: 'Unknown resource' });

    const resourceUrl = `${request.protocol}://${request.host}${request.url}`;
    const requirements = quote(entry, resourceUrl, opts.env);

    const header = request.headers[X_PAYMENT_HEADER];
    if (typeof header !== 'string' || header.length === 0) {
      return reply.code(402).send(paymentRequired(requirements, 'X-PAYMENT header is required'));
    }

    // Paid retry.
    await verifyVoucher(header, requirements);
    // TODO: record a Receipt, set the X-PAYMENT-RESPONSE header, and return the resource body.
    return reply.code(200).send({ resource: entry.resourceId });
  });

  /** POST /x402/settle: operator trigger for a settlement batch. Stub: returns 501. */
  app.post('/x402/settle', async () => {
    await settleBatch();
  });
}
