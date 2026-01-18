/**
 * Elasticsearch Service
 * Fast search for products, customers, orders
 */

const { Client } = require('@elastic/elasticsearch');

class ElasticsearchService {
  constructor() {
    this.client = null;
    this.isConnected = false;
    this.enabled = process.env.USE_ELASTICSEARCH === 'true';
  }

  /**
   * Initialize Elasticsearch client
   */
  async connect() {
    if (!this.enabled) {
      console.log('[ELASTICSEARCH] Disabled, using database search');
      return;
    }

    try {
      this.client = new Client({
        node: process.env.ELASTICSEARCH_URL || 'http://localhost:9200',
        auth: process.env.ELASTICSEARCH_API_KEY ? {
          apiKey: process.env.ELASTICSEARCH_API_KEY
        } : undefined
      });

      const health = await this.client.cluster.health();
      this.isConnected = true;
      console.log(`✅ Elasticsearch connected (${health.status})`);
    } catch (error) {
      console.warn('[ELASTICSEARCH] Connection failed:', error.message);
      this.enabled = false;
    }
  }

  /**
   * Index product
   */
  async indexProduct(product) {
    if (!this.enabled) return;

    try {
      await this.client.index({
        index: 'products',
        id: product.id,
        document: {
          name: product.name,
          sku: product.sku,
          category: product.category,
          price: product.price,
          description: product.description,
          tenant_id: product.tenant_id,
          is_active: product.is_active,
          updated_at: new Date()
        }
      });
    } catch (error) {
      console.error('[ELASTICSEARCH] Index product error:', error.message);
    }
  }

  /**
   * Index customer
   */
  async indexCustomer(customer) {
    if (!this.enabled) return;

    try {
      await this.client.index({
        index: 'customers',
        id: customer.id,
        document: {
          name: customer.name,
          email: customer.email,
          phone: customer.phone,
          company: customer.company,
          city: customer.city,
          tenant_id: customer.tenant_id,
          updated_at: new Date()
        }
      });
    } catch (error) {
      console.error('[ELASTICSEARCH] Index customer error:', error.message);
    }
  }

  /**
   * Search products with fuzzy matching
   */
  async searchProducts(query, tenantId, options = {}) {
    if (!this.enabled) return null;

    const { limit = 20, offset = 0 } = options;

    try {
      const result = await this.client.search({
        index: 'products',
        body: {
          query: {
            bool: {
              must: [
                { match: { tenant_id: tenantId } },
                {
                  multi_match: {
                    query,
                    fields: ['name^3', 'sku^2', 'description', 'category'],
                    fuzziness: 'AUTO'
                  }
                }
              ]
            }
          },
          from: offset,
          size: limit
        }
      });

      return result.hits.hits.map(hit => ({
        ...hit._source,
        id: hit._id,
        score: hit._score
      }));
    } catch (error) {
      console.error('[ELASTICSEARCH] Search products error:', error.message);
      return null;
    }
  }

  /**
   * Search customers
   */
  async searchCustomers(query, tenantId, options = {}) {
    if (!this.enabled) return null;

    const { limit = 20 } = options;

    try {
      const result = await this.client.search({
        index: 'customers',
        body: {
          query: {
            bool: {
              must: [
                { match: { tenant_id: tenantId } },
                {
                  multi_match: {
                    query,
                    fields: ['name^3', 'email', 'phone^2', 'company'],
                    fuzziness: 'AUTO'
                  }
                }
              ]
            }
          },
          size: limit
        }
      });

      return result.hits.hits.map(hit => ({
        ...hit._source,
        id: hit._id,
        score: hit._score
      }));
    } catch (error) {
      console.error('[ELASTICSEARCH] Search customers error:', error.message);
      return null;
    }
  }

  /**
   * Autocomplete suggestions
   */
  async autocomplete(query, index, field, tenantId) {
    if (!this.enabled) return [];

    try {
      const result = await this.client.search({
        index,
        body: {
          query: {
            bool: {
              must: [
                { match: { tenant_id: tenantId } },
                { prefix: { [field]: query.toLowerCase() } }
              ]
            }
          },
          size: 10
        }
      });

      return result.hits.hits.map(hit => hit._source[field]);
    } catch (error) {
      console.error('[ELASTICSEARCH] Autocomplete error:', error.message);
      return [];
    }
  }

  /**
   * Bulk index documents
   */
  async bulkIndex(index, documents) {
    if (!this.enabled) return;

    try {
      const body = documents.flatMap(doc => [
        { index: { _index: index, _id: doc.id } },
        doc
      ]);

      await this.client.bulk({ body, refresh: true });
    } catch (error) {
      console.error('[ELASTICSEARCH] Bulk index error:', error.message);
    }
  }

  /**
   * Delete document
   */
  async deleteDocument(index, id) {
    if (!this.enabled) return;

    try {
      await this.client.delete({ index, id });
    } catch (error) {
      console.error('[ELASTICSEARCH] Delete error:', error.message);
    }
  }
}

module.exports = new ElasticsearchService();
