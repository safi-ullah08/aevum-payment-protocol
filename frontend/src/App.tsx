import { NavLink, Navigate, Route, Routes } from 'react-router-dom';
import { AddNetworkButton } from './components/AddNetworkButton';
import { ConnectButton } from './components/ConnectButton';
import { AgentPolicyPage } from './pages/AgentPolicy';
import { MerchantPage } from './pages/Merchant';
import { MyChannelsPage } from './pages/MyChannels';
import { PlansPage } from './pages/Plans';
import { SubscribePage } from './pages/Subscribe';

const NAV = [
  { to: '/plans', label: 'Plans' },
  { to: '/subscribe', label: 'Subscribe' },
  { to: '/channels', label: 'My channels' },
  { to: '/merchant', label: 'Merchant' },
  { to: '/agent-policy', label: 'Agent policy' },
] as const;

export function App() {
  return (
    <div className="app">
      <header className="header">
        <span className="brand">Aevum Payments</span>
        <nav className="nav">
          {NAV.map(({ to, label }) => (
            <NavLink key={to} to={to} className={({ isActive }) => (isActive ? 'nav-link active' : 'nav-link')}>
              {label}
            </NavLink>
          ))}
        </nav>
        <div className="wallet">
          <AddNetworkButton />
          <ConnectButton />
        </div>
      </header>
      <main className="main">
        <Routes>
          <Route path="/" element={<Navigate to="/plans" replace />} />
          <Route path="/plans" element={<PlansPage />} />
          <Route path="/subscribe" element={<SubscribePage />} />
          <Route path="/subscribe/:planId" element={<SubscribePage />} />
          <Route path="/channels" element={<MyChannelsPage />} />
          <Route path="/merchant" element={<MerchantPage />} />
          <Route path="/agent-policy" element={<AgentPolicyPage />} />
          <Route path="*" element={<p>Not found.</p>} />
        </Routes>
      </main>
    </div>
  );
}
