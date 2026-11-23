import type { Bytes32, Plan } from '@aevum/shared';

/** A paywalled resource and the plan that prices it. */
export interface CatalogEntry {
  resourceId: string;
  description: string;
  mimeType: string;
  plan: Plan;
}

const ZERO32: Bytes32 = `0x${'0'.repeat(64)}`;

/**
 * Placeholder catalog so GET /resource/:id can return a well-formed 402 before contracts are deployed.
 * TODO: replace the hard-coded plan with SubscriptionPlans.getPlan(planId) read on-chain.
 */
const PLACEHOLDER_CATALOG: ReadonlyMap<string, CatalogEntry> = new Map([
  [
    'demo',
    {
      resourceId: 'demo',
      description: 'Demo paywalled resource (placeholder plan)',
      mimeType: 'application/json',
      plan: {
        id: ZERO32,
        merchant: ZERO32,
        amountPerPeriod: 10_000n, // 0.01 tUSD8 (6 decimals)
        period: 0n,
        maxCatchUpPeriods: 0,
        disputeWindow: 86_400n,
        escrowAllowed: true,
        allowanceAllowed: true,
      },
    },
  ],
]);

export function findResource(resourceId: string): CatalogEntry | undefined {
  return PLACEHOLDER_CATALOG.get(resourceId);
}
