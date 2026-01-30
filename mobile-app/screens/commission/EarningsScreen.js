/**
 * Earnings Screen - View commissions and payouts
 */

import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  FlatList,
  ActivityIndicator,
  RefreshControl
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import commissionService from '../services/commissionService';
import moment from 'moment';

const EarningsScreen = ({ navigation }) => {
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [summary, setSummary] = useState(null);
  const [transactions, setTransactions] = useState([]);
  const [targets, setTargets] = useState([]);
  const [selectedPeriod, setSelectedPeriod] = useState('month'); // 'month', 'quarter', 'year'

  useEffect(() => {
    loadData();
  }, [selectedPeriod]);

  const loadData = async () => {
    try {
      setLoading(true);

      // Calculate date range based on selected period
      let startDate, endDate;
      const now = new Date();

      if (selectedPeriod === 'month') {
        startDate = new Date(now.getFullYear(), now.getMonth(), 1);
        endDate = new Date(now.getFullYear(), now.getMonth() + 1, 0);
      } else if (selectedPeriod === 'quarter') {
        const quarter = Math.floor(now.getMonth() / 3);
        startDate = new Date(now.getFullYear(), quarter * 3, 1);
        endDate = new Date(now.getFullYear(), quarter * 3 + 3, 0);
      } else {
        startDate = new Date(now.getFullYear(), 0, 1);
        endDate = new Date(now.getFullYear(), 11, 31);
      }

      // Load summary
      const summaryResult = await commissionService.getSummary(
        startDate.toISOString(),
        endDate.toISOString()
      );

      if (summaryResult.success) {
        setSummary(summaryResult.summary);
      }

      // Load transactions
      const transactionsResult = await commissionService.getTransactions(50);
      if (transactionsResult.success) {
        setTransactions(transactionsResult.transactions);
      }

      // Load targets
      const targetsResult = await commissionService.getTargets();
      if (targetsResult.success) {
        setTargets(targetsResult.targets);
      }
    } catch (error) {
      console.error('Error loading earnings data:', error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  const onRefresh = () => {
    setRefreshing(true);
    loadData();
  };

  const renderTransaction = ({ item }) => {
    const getStatusColor = (status) => {
      switch (status) {
        case 'paid':
          return '#34C759';
        case 'approved':
          return '#007AFF';
        case 'pending':
          return '#FF9500';
        case 'disputed':
          return '#FF3B30';
        default:
          return '#999';
      }
    };

    return (
      <View style={styles.transactionCard}>
        <View style={styles.transactionHeader}>
          <View style={styles.transactionInfo}>
            <Text style={styles.customerName}>{item.customer_name || 'Direct Sale'}</Text>
            <Text style={styles.transactionDate}>
              {moment(item.transaction_date).format('MMM DD, YYYY')}
            </Text>
          </View>
          <View style={styles.transactionAmount}>
            <Text style={styles.commissionAmount}>
              ₹{parseFloat(item.commission_amount).toFixed(2)}
            </Text>
            <Text style={styles.commissionRate}>{parseFloat(item.commission_rate).toFixed(1)}%</Text>
          </View>
        </View>

        <View style={styles.transactionFooter}>
          <Text style={styles.saleAmount}>Sale: ₹{parseFloat(item.sale_amount).toFixed(2)}</Text>
          <View style={[styles.statusBadge, { backgroundColor: getStatusColor(item.payout_status) + '20' }]}>
            <Text style={[styles.statusText, { color: getStatusColor(item.payout_status) }]}>
              {item.payout_status}
            </Text>
          </View>
        </View>
      </View>
    );
  };

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#007AFF" />
        <Text style={styles.loadingText}>Loading earnings...</Text>
      </View>
    );
  }

  return (
    <ScrollView
      style={styles.container}
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
    >
      {/* Period Selector */}
      <View style={styles.periodSelector}>
        {['month', 'quarter', 'year'].map(period => (
          <TouchableOpacity
            key={period}
            style={[
              styles.periodButton,
              selectedPeriod === period && styles.periodButtonActive
            ]}
            onPress={() => setSelectedPeriod(period)}
          >
            <Text style={[
              styles.periodButtonText,
              selectedPeriod === period && styles.periodButtonTextActive
            ]}>
              {period === 'month' ? 'This Month' : period === 'quarter' ? 'This Quarter' : 'This Year'}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* Summary Cards */}
      {summary && (
        <View style={styles.summarySection}>
          <View style={styles.summaryRow}>
            <View style={styles.summaryCard}>
              <Icon name="account-balance-wallet" size={32} color="#007AFF" />
              <Text style={styles.summaryValue}>₹{parseFloat(summary.total_commission || 0).toFixed(2)}</Text>
              <Text style={styles.summaryLabel}>Total Commission</Text>
            </View>

            <View style={styles.summaryCard}>
              <Icon name="pending" size={32} color="#FF9500" />
              <Text style={styles.summaryValue}>₹{parseFloat(summary.pending_commission || 0).toFixed(2)}</Text>
              <Text style={styles.summaryLabel}>Pending</Text>
            </View>
          </View>

          <View style={styles.summaryRow}>
            <View style={styles.summaryCard}>
              <Icon name="check-circle" size={32} color="#34C759" />
              <Text style={styles.summaryValue}>₹{parseFloat(summary.paid_commission || 0).toFixed(2)}</Text>
              <Text style={styles.summaryLabel}>Paid</Text>
            </View>

            <View style={styles.summaryCard}>
              <Icon name="trending-up" size={32} color="#FF3B30" />
              <Text style={styles.summaryValue}>₹{parseFloat(summary.total_sales || 0).toFixed(2)}</Text>
              <Text style={styles.summaryLabel}>Total Sales</Text>
            </View>
          </View>

          <View style={styles.avgRateCard}>
            <Text style={styles.avgRateLabel}>Average Commission Rate</Text>
            <Text style={styles.avgRateValue}>
              {summary.avg_commission_rate ? parseFloat(summary.avg_commission_rate).toFixed(2) : '0.00'}%
            </Text>
            <Text style={styles.transactionCountText}>
              {summary.transaction_count || 0} transactions
            </Text>
          </View>
        </View>
      )}

      {/* Targets Section */}
      {targets.length > 0 && (
        <View style={styles.targetsSection}>
          <Text style={styles.sectionTitle}>Active Targets</Text>
          {targets.map(target => (
            <TouchableOpacity
              key={target.id}
              style={styles.targetCard}
              onPress={() => {
                // Navigate to target detail screen
                navigation.navigate('TargetDetail', { targetId: target.id });
              }}
            >
              <View style={styles.targetHeader}>
                <Text style={styles.targetPeriod}>
                  {target.target_period.toUpperCase()}
                </Text>
                <Text style={styles.targetAmount}>
                  ₹{parseFloat(target.sales_target_amount).toFixed(0)}
                </Text>
              </View>
              <Text style={styles.targetDate}>
                {moment(target.period_start).format('MMM DD')} - {moment(target.period_end).format('MMM DD, YYYY')}
              </Text>
              {target.bonus_percentage && (
                <View style={styles.bonusBadge}>
                  <Icon name="star" size={16} color="#FFD700" />
                  <Text style={styles.bonusText}>
                    +{parseFloat(target.bonus_percentage).toFixed(1)}% bonus if achieved
                  </Text>
                </View>
              )}
            </TouchableOpacity>
          ))}
        </View>
      )}

      {/* Recent Transactions */}
      <View style={styles.transactionsSection}>
        <Text style={styles.sectionTitle}>Recent Transactions</Text>
        {transactions.length > 0 ? (
          transactions.map(transaction => (
            <View key={transaction.id}>
              {renderTransaction({ item: transaction })}
            </View>
          ))
        ) : (
          <View style={styles.emptyState}>
            <Icon name="receipt-long" size={48} color="#ccc" />
            <Text style={styles.emptyText}>No transactions yet</Text>
          </View>
        )}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5'
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5F5F5'
  },
  loadingText: {
    marginTop: 10,
    fontSize: 16,
    color: '#666'
  },
  periodSelector: {
    flexDirection: 'row',
    backgroundColor: '#fff',
    padding: 10,
    borderBottomWidth: 1,
    borderColor: '#E5E5E5'
  },
  periodButton: {
    flex: 1,
    padding: 10,
    marginHorizontal: 5,
    borderRadius: 8,
    backgroundColor: '#F5F5F5',
    alignItems: 'center'
  },
  periodButtonActive: {
    backgroundColor: '#007AFF'
  },
  periodButtonText: {
    fontSize: 14,
    fontWeight: '500',
    color: '#666'
  },
  periodButtonTextActive: {
    color: '#fff'
  },
  summarySection: {
    padding: 15
  },
  summaryRow: {
    flexDirection: 'row',
    marginBottom: 15
  },
  summaryCard: {
    flex: 1,
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 15,
    marginHorizontal: 5,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2
  },
  summaryValue: {
    fontSize: 18,
    fontWeight: '600',
    color: '#000',
    marginTop: 8
  },
  summaryLabel: {
    fontSize: 12,
    color: '#999',
    marginTop: 4
  },
  avgRateCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2
  },
  avgRateLabel: {
    fontSize: 14,
    color: '#666',
    marginBottom: 8
  },
  avgRateValue: {
    fontSize: 32,
    fontWeight: '700',
    color: '#007AFF'
  },
  transactionCountText: {
    fontSize: 12,
    color: '#999',
    marginTop: 4
  },
  targetsSection: {
    padding: 15
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#666',
    marginBottom: 15,
    textTransform: 'uppercase',
    letterSpacing: 0.5
  },
  targetCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 15,
    marginBottom: 10,
    borderLeftWidth: 4,
    borderLeftColor: '#007AFF',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2
  },
  targetHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8
  },
  targetPeriod: {
    fontSize: 12,
    fontWeight: '600',
    color: '#007AFF',
    letterSpacing: 1
  },
  targetAmount: {
    fontSize: 20,
    fontWeight: '700',
    color: '#000'
  },
  targetDate: {
    fontSize: 14,
    color: '#666',
    marginBottom: 8
  },
  bonusBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FFF8DC',
    paddingHorizontal: 10,
    paddingVertical: 5,
    borderRadius: 12,
    alignSelf: 'flex-start'
  },
  bonusText: {
    fontSize: 12,
    color: '#B8860B',
    marginLeft: 5,
    fontWeight: '500'
  },
  transactionsSection: {
    padding: 15,
    paddingTop: 0
  },
  transactionCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 15,
    marginBottom: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2
  },
  transactionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 10
  },
  transactionInfo: {
    flex: 1
  },
  customerName: {
    fontSize: 16,
    fontWeight: '500',
    color: '#000',
    marginBottom: 4
  },
  transactionDate: {
    fontSize: 12,
    color: '#999'
  },
  transactionAmount: {
    alignItems: 'flex-end'
  },
  commissionAmount: {
    fontSize: 18,
    fontWeight: '700',
    color: '#34C759'
  },
  commissionRate: {
    fontSize: 12,
    color: '#666',
    marginTop: 2
  },
  transactionFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingTop: 10,
    borderTopWidth: 1,
    borderColor: '#F0F0F0'
  },
  saleAmount: {
    fontSize: 14,
    color: '#666'
  },
  statusBadge: {
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 12
  },
  statusText: {
    fontSize: 12,
    fontWeight: '600',
    textTransform: 'capitalize'
  },
  emptyState: {
    alignItems: 'center',
    padding: 40
  },
  emptyText: {
    fontSize: 16,
    color: '#999',
    marginTop: 10
  }
});

export default EarningsScreen;
