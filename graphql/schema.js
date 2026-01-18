/**
 * GraphQL Schema and Resolvers
 * Flexible query API for Salesmate
 */

const { gql } = require('apollo-server-express');
const { db } = require('./config');

// GraphQL Type Definitions
const typeDefs = gql`
  type Product {
    id: ID!
    name: String!
    sku: String
    price: Float
    category: String
    description: String
    is_active: Boolean
  }

  type Customer {
    id: ID!
    name: String!
    email: String
    phone: String
    company: String
    city: String
  }

  type Visit {
    id: ID!
    customer_name: String!
    visit_date: String!
    visit_type: String
    salesman_id: String!
    remarks: String
  }

  type Salesman {
    id: ID!
    name: String!
    email: String
    phone: String
    territory: String
    is_active: Boolean
  }

  type Order {
    id: ID!
    customer_name: String
    total_amount: Float
    status: String
    created_at: String
  }

  type Query {
    products(limit: Int, search: String): [Product]
    product(id: ID!): Product
    customers(limit: Int, search: String): [Customer]
    customer(id: ID!): Customer
    visits(salesmanId: String, limit: Int): [Visit]
    salesmen(isActive: Boolean): [Salesman]
    orders(status: String, limit: Int): [Order]
  }

  type Mutation {
    createProduct(name: String!, sku: String, price: Float, category: String): Product
    updateProduct(id: ID!, name: String, price: Float, is_active: Boolean): Product
    deleteProduct(id: ID!): Boolean
  }
`;

// Resolvers
const resolvers = {
  Query: {
    products: (_, { limit = 50, search }, context) => {
      const tenantId = context.tenantId || '101f04af63cbefc2bf8f0a98b9ae1205';
      
      let query = 'SELECT * FROM products WHERE tenant_id = ?';
      const params = [tenantId];

      if (search) {
        query += ' AND (name LIKE ? OR sku LIKE ?)';
        params.push(`%${search}%`, `%${search}%`);
      }

      query += ' LIMIT ?';
      params.push(limit);

      return db.prepare(query).all(...params);
    },

    product: (_, { id }) => {
      return db.prepare('SELECT * FROM products WHERE id = ?').get(id);
    },

    customers: (_, { limit = 50, search }, context) => {
      const tenantId = context.tenantId || '101f04af63cbefc2bf8f0a98b9ae1205';
      
      let query = 'SELECT * FROM customers WHERE tenant_id = ?';
      const params = [tenantId];

      if (search) {
        query += ' AND (name LIKE ? OR email LIKE ? OR phone LIKE ?)';
        params.push(`%${search}%`, `%${search}%`, `%${search}%`);
      }

      query += ' LIMIT ?';
      params.push(limit);

      return db.prepare(query).all(...params);
    },

    customer: (_, { id }) => {
      return db.prepare('SELECT * FROM customers WHERE id = ?').get(id);
    },

    visits: (_, { salesmanId, limit = 50 }, context) => {
      const tenantId = context.tenantId || '101f04af63cbefc2bf8f0a98b9ae1205';
      
      let query = 'SELECT * FROM visits WHERE tenant_id = ?';
      const params = [tenantId];

      if (salesmanId) {
        query += ' AND salesman_id = ?';
        params.push(salesmanId);
      }

      query += ' ORDER BY created_at DESC LIMIT ?';
      params.push(limit);

      return db.prepare(query).all(...params);
    },

    salesmen: (_, { isActive }, context) => {
      const tenantId = context.tenantId || '101f04af63cbefc2bf8f0a98b9ae1205';
      
      let query = 'SELECT * FROM salesmen WHERE tenant_id = ?';
      const params = [tenantId];

      if (isActive !== undefined) {
        query += ' AND is_active = ?';
        params.push(isActive ? 1 : 0);
      }

      return db.prepare(query).all(...params);
    },

    orders: (_, { status, limit = 50 }, context) => {
      const tenantId = context.tenantId || '101f04af63cbefc2bf8f0a98b9ae1205';
      
      let query = 'SELECT * FROM orders WHERE tenant_id = ?';
      const params = [tenantId];

      if (status) {
        query += ' AND status = ?';
        params.push(status);
      }

      query += ' ORDER BY created_at DESC LIMIT ?';
      params.push(limit);

      return db.prepare(query).all(...params);
    }
  },

  Mutation: {
    createProduct: (_, { name, sku, price, category }, context) => {
      const tenantId = context.tenantId || '101f04af63cbefc2bf8f0a98b9ae1205';
      const id = require('crypto').randomBytes(16).toString('hex');

      db.prepare(`
        INSERT INTO products (id, tenant_id, name, sku, price, category, is_active, created_at)
        VALUES (?, ?, ?, ?, ?, ?, 1, datetime('now'))
      `).run(id, tenantId, name, sku, price, category);

      return db.prepare('SELECT * FROM products WHERE id = ?').get(id);
    },

    updateProduct: (_, { id, name, price, is_active }) => {
      const updates = [];
      const params = [];

      if (name) {
        updates.push('name = ?');
        params.push(name);
      }
      if (price !== undefined) {
        updates.push('price = ?');
        params.push(price);
      }
      if (is_active !== undefined) {
        updates.push('is_active = ?');
        params.push(is_active ? 1 : 0);
      }

      if (updates.length > 0) {
        params.push(id);
        db.prepare(`UPDATE products SET ${updates.join(', ')} WHERE id = ?`).run(...params);
      }

      return db.prepare('SELECT * FROM products WHERE id = ?').get(id);
    },

    deleteProduct: (_, { id }) => {
      const result = db.prepare('DELETE FROM products WHERE id = ?').run(id);
      return result.changes > 0;
    }
  }
};

module.exports = { typeDefs, resolvers };
