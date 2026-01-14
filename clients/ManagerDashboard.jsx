/**
 * React Components for Salesmate Manager Dashboard
 * Use with: npm install react react-dom recharts
 */

import React, { useState, useEffect } from 'react';

/**
 * Team Overview Component
 * Shows real-time team performance and metrics
 */
export const TeamOverview = ({ api }) => {
  const [overview, setOverview] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchOverview = async () => {
      try {
        const data = await api.getTeamOverview();
        setOverview(data.overview);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchOverview();
    const interval = setInterval(fetchOverview, 30000); // Refresh every 30s
    return () => clearInterval(interval);
  }, [api]);

  if (loading) return <div className="loading">Loading overview...</div>;
  if (error) return <div className="error">Error: {error}</div>;
  if (!overview) return <div>No data</div>;

  return (
    <div className="team-overview">
      <h2>Team Overview - {overview.date}</h2>
      
      <div className="stats-grid">
        <div className="stat-card">
          <h3>Team Size</h3>
          <p className="stat-number">{overview.total_salesmen}</p>
        </div>
        <div className="stat-card">
          <h3>Today's Visits</h3>
          <p className="stat-number">{overview.today_stats.total_visits}</p>
          <p className="stat-label">
            {overview.today_stats.completed_visits} completed
          </p>
        </div>
        <div className="stat-card">
          <h3>Today's Orders</h3>
          <p className="stat-number">{overview.today_stats.total_orders}</p>
          <p className="stat-label">
            ₹{overview.today_stats.total_revenue.toLocaleString()}
          </p>
        </div>
        <div className="stat-card">
          <h3>Avg Order Value</h3>
          <p className="stat-number">₹{overview.today_stats.average_order_value.toLocaleString()}</p>
        </div>
      </div>

      <div className="team-grid">
        <div className="team-section">
          <h3>✅ Top Performers</h3>
          <ul className="performer-list">
            {overview.top_performers.map((perf, idx) => (
              <li key={idx}>
                {perf.name} - {perf.progress}%
              </li>
            ))}
          </ul>
        </div>

        <div className="team-section">
          <h3>⚠️ Needs Attention</h3>
          <ul className="at-risk-list">
            {overview.at_risk.map((risk, idx) => (
              <li key={idx}>
                {risk.name} - {risk.progress}% (gap: {risk.gap}%)
              </li>
            ))}
          </ul>
        </div>
      </div>

      <div className="team-members">
        <h3>All Team Members</h3>
        <table>
          <thead>
            <tr>
              <th>Name</th>
              <th>Visits (Today)</th>
              <th>Progress</th>
              <th>Orders (Today)</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            {overview.team_members.map((member) => (
              <tr key={member.id}>
                <td>{member.name}</td>
                <td>{member.today_visits}</td>
                <td>
                  <div className="progress-bar">
                    <div 
                      className="progress-fill" 
                      style={{ width: `${member.visits_progress}%` }}
                    >
                      {member.visits_progress}%
                    </div>
                  </div>
                </td>
                <td>{member.today_orders}</td>
                <td>
                  <span className={`badge badge-${member.status}`}>
                    {member.status}
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

/**
 * Analytics Component
 * Shows performance trends over time
 */
export const Analytics = ({ api, days = 7 }) => {
  const [analytics, setAnalytics] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchAnalytics = async () => {
      try {
        const data = await api.getAnalytics(days);
        setAnalytics(data.analytics);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchAnalytics();
  }, [api, days]);

  if (loading) return <div className="loading">Loading analytics...</div>;
  if (error) return <div className="error">Error: {error}</div>;
  if (!analytics) return <div>No data</div>;

  const summary = analytics.summary;

  return (
    <div className="analytics">
      <h2>Performance Analytics ({days} Days)</h2>

      <div className="summary-cards">
        <div className="card">
          <h3>Total Visits</h3>
          <p className="number">{summary.total_visits}</p>
          <p className="label">{summary.average_daily_visits}/day avg</p>
        </div>
        <div className="card">
          <h3>Total Orders</h3>
          <p className="number">{summary.total_orders}</p>
          <p className="label">{summary.average_daily_orders}/day avg</p>
        </div>
        <div className="card">
          <h3>Total Revenue</h3>
          <p className="number">₹{summary.total_revenue.toLocaleString()}</p>
          <p className="label">₹{summary.average_daily_revenue.toLocaleString()}/day</p>
        </div>
        <div className="card">
          <h3>Completion Rate</h3>
          <p className="number">{summary.completion_rate}%</p>
          <p className="label">of visits completed</p>
        </div>
      </div>

      <div className="daily-metrics">
        <h3>Daily Breakdown</h3>
        <table>
          <thead>
            <tr>
              <th>Date</th>
              <th>Visits</th>
              <th>Orders</th>
              <th>Revenue</th>
            </tr>
          </thead>
          <tbody>
            {analytics.daily_metrics.map((metric) => (
              <tr key={metric.date}>
                <td>{new Date(metric.date).toLocaleDateString()}</td>
                <td>{metric.visits}</td>
                <td>{metric.orders}</td>
                <td>₹{metric.revenue.toLocaleString()}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

/**
 * Alerts Component
 * Shows critical, warning, and info alerts
 */
export const Alerts = ({ api }) => {
  const [alerts, setAlerts] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchAlerts = async () => {
      try {
        const data = await api.getAlerts();
        setAlerts(data.alerts);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchAlerts();
    const interval = setInterval(fetchAlerts, 60000); // Refresh every minute
    return () => clearInterval(interval);
  }, [api]);

  if (loading) return <div className="loading">Loading alerts...</div>;
  if (error) return <div className="error">Error: {error}</div>;
  if (!alerts) return <div>No alerts</div>;

  return (
    <div className="alerts">
      <h2>Real-Time Alerts</h2>

      {alerts.critical.length > 0 && (
        <div className="alert-section critical">
          <h3>🔴 Critical ({alerts.critical.length})</h3>
          <ul>
            {alerts.critical.map((alert, idx) => (
              <li key={idx}>
                <strong>{alert.message}</strong>
                <p>{alert.salesman_id}</p>
              </li>
            ))}
          </ul>
        </div>
      )}

      {alerts.warning.length > 0 && (
        <div className="alert-section warning">
          <h3>🟡 Warning ({alerts.warning.length})</h3>
          <ul>
            {alerts.warning.map((alert, idx) => (
              <li key={idx}>
                <strong>{alert.message}</strong>
                <p>{alert.salesman_id}</p>
              </li>
            ))}
          </ul>
        </div>
      )}

      {alerts.info.length > 0 && (
        <div className="alert-section info">
          <h3>🔵 Info ({alerts.info.length})</h3>
          <ul>
            {alerts.info.map((alert, idx) => (
              <li key={idx}>
                <p>{alert.message}</p>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

/**
 * Dashboard Component
 * Complete manager dashboard combining all views
 */
export const ManagerDashboard = ({ api }) => {
  const [activeTab, setActiveTab] = useState('overview');

  return (
    <div className="manager-dashboard">
      <header className="dashboard-header">
        <h1>Sales Manager Dashboard</h1>
        <p>Real-time team performance and analytics</p>
      </header>

      <nav className="dashboard-nav">
        <button 
          className={activeTab === 'overview' ? 'active' : ''}
          onClick={() => setActiveTab('overview')}
        >
          📊 Overview
        </button>
        <button 
          className={activeTab === 'analytics' ? 'active' : ''}
          onClick={() => setActiveTab('analytics')}
        >
          📈 Analytics
        </button>
        <button 
          className={activeTab === 'alerts' ? 'active' : ''}
          onClick={() => setActiveTab('alerts')}
        >
          🚨 Alerts
        </button>
      </nav>

      <main className="dashboard-content">
        {activeTab === 'overview' && <TeamOverview api={api} />}
        {activeTab === 'analytics' && <Analytics api={api} days={7} />}
        {activeTab === 'alerts' && <Alerts api={api} />}
      </main>
    </div>
  );
};

export default ManagerDashboard;
