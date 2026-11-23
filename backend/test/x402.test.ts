import { describe, it } from 'vitest';

describe('x402 gateway', () => {
  it.skip('GET /resource/:id without X-PAYMENT returns 402 with PaymentRequirements built from the plan', () => {
    // Asserts: status 402; body.x402Version === 1; body.accepts[0] has the plan price, tUSD8 asset,
    // merchant payTo, chainId 44005 network and the ChannelCore address in extra.
  });
});
