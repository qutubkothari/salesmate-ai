/**
 * Commission Service for React Native
 */

import api from './api';

class CommissionService {
  /**
   * Get commission summary
   */
  async getSummary(startDate = null, endDate = null) {
    try {
      let url = '/api/commission/summary';
      
      if (startDate || endDate) {
        const params = new URLSearchParams();
        if (startDate) params.append('startDate', startDate);
        if (endDate) params.append('endDate', endDate);
        url += `?${params.toString()}`;
      }

      const response = await api.get(url);
      return response.data;
    } catch (error) {
      console.error('[COMMISSION] Get summary error:', error);
      throw error;
    }
  }

  /**
   * Get commission transactions
   */
  async getTransactions(limit = 50) {
    try {
      const response = await api.get(`/api/commission/transactions?limit=${limit}`);
      return response.data;
    } catch (error) {
      console.error('[COMMISSION] Get transactions error:', error);
      throw error;
    }
  }

  /**
   * Get active targets
   */
  async getTargets() {
    try {
      const response = await api.get('/api/commission/targets');
      return response.data;
    } catch (error) {
      console.error('[COMMISSION] Get targets error:', error);
      throw error;
    }
  }

  /**
   * Get target achievement
   */
  async getTargetAchievement(targetId) {
    try {
      const response = await api.get(`/api/commission/targets/${targetId}/achievement`);
      return response.data;
    } catch (error) {
      console.error('[COMMISSION] Get achievement error:', error);
      throw error;
    }
  }
}

export default new CommissionService();
