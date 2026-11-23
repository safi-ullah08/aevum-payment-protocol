/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_CHANNEL_CORE_ADDRESS?: string;
  readonly VITE_SUBSCRIPTION_PLANS_ADDRESS?: string;
  readonly VITE_AGENT_POLICY_ADDRESS?: string;
  readonly VITE_DISPUTE_MANAGER_ADDRESS?: string;
  readonly VITE_CLAIM_TOKEN_ADDRESS?: string;
  readonly VITE_BACKEND_URL?: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
