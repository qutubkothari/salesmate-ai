# 🔍 BOT DIAGNOSTIC & TEST SCENARIOS

## 📊 System Check Results (December 28, 2025)

### ⚠️ **CRITICAL FINDINGS:**

1. **✗ No `.env` file found** - App may be using system environment variables or different config
2. **✓ App is running** - Node.js processes detected on ports 3000 and 4000
3. **⚠️ Port 3000 responding** - But this appears to be a different service (web dashboard?)
4. **✗ Main app (port 8081) not responding** - Expected port for WhatsApp bot not accessible
5. **✗ Dependencies installed** - But configuration incomplete

---

## 🚨 **BEFORE TESTING - SETUP REQUIRED:**

### **You MUST configure the following:**

1. **Create `.env` file** with actual credentials:
   ```bash
   # Copy from template
   cp .env.oracle-template .env
   
   # Edit with your actual values:
   - OPENAI_API_KEY=sk-...
   - SUPABASE_URL=https://...
   - SUPABASE_ANON_KEY=...
   - SUPABASE_SERVICE_KEY=...
   ```

2. **Start the main app:**
   ```bash
   npm start
   # Should run on port 8081 (or PORT env variable)
   ```

3. **Verify WhatsApp connection:**
   - Desktop Agent must be running and connected
   - OR WAHA server must be configured and connected

---

## 🎯 TEST SCENARIOS (Once Configured)

### **Category 1: Basic Product Queries (Database Reading)**

#### Scenario 1.1: Simple Product Price Inquiry
```
Message: "price of 8x80"
```
**Expected Behavior:**
- Bot queries products table
- Finds product by code "8x80"
- Returns price with per-piece and per-carton breakdown
- Uses personalized pricing if customer has purchase history

**Tests:**
- ✅ Product search (vector/text)
- ✅ Price formatting
- ✅ Customer recognition
- ✅ Response generation

---

#### Scenario 1.2: Multi-Product Price Query
```
Message: "give me prices for 8x80, 8x100, and 10x140"
```
**Expected Behavior:**
- AI extracts multiple product codes
- Queries database for all products
- Returns formatted list with prices
- Calculates volume discounts if applicable

**Tests:**
- ✅ Multi-product extraction (AI)
- ✅ Batch database queries
- ✅ Price display formatting
- ✅ Volume discount logic

---

#### Scenario 1.3: Natural Language Product Search
```
Message: "do you have nylon anchors?"
```
**Expected Behavior:**
- AI understands "nylon anchors" (not a product code)
- Uses vector search on product descriptions/categories
- Returns matching products with categories
- Suggests specific product codes

**Tests:**
- ✅ Vector embeddings search
- ✅ Semantic understanding
- ✅ Product recommendation
- ✅ Category matching

---

#### Scenario 1.4: Product Availability Check
```
Message: "8x80 available hai kya?"
```
**Expected Behavior:**
- Detects "availability check" intent (Hinglish)
- Queries product stock status
- Returns availability + price
- Responds in same language (Hinglish)

**Tests:**
- ✅ Language detection (Hinglish)
- ✅ Intent classification (product_info)
- ✅ Stock checking
- ✅ Multi-language response

---

### **Category 2: Order Processing (Database Write + Read)**

#### Scenario 2.1: Simple Order Placement
```
Message: "I need 10 cartons of 8x80"
```
**Expected Behavior:**
- Detects ORDER intent
- Extracts product code and quantity
- Adds to cart
- Returns order summary with total

**Tests:**
- ✅ Intent classification (order)
- ✅ Entity extraction (product, quantity, unit)
- ✅ Cart operations (database write)
- ✅ Order summary generation

---

#### Scenario 2.2: Order with Volume Discount
```
Message: "I want 100000 pieces of 10x100"
```
**Expected Behavior:**
- Recognizes large volume order
- Calculates automatic volume discount (15% for 100k+ pieces)
- Shows before/after pricing
- Highlights savings

**Tests:**
- ✅ Volume calculation
- ✅ Discount tier logic
- ✅ Price comparison display
- ✅ Savings calculation

---

#### Scenario 2.3: Multi-Product Order
```
Message: "I need 8x80 5 cartons, 8x100 10 cartons, and 10x140 3 cartons"
```
**Expected Behavior:**
- Extracts multiple products with quantities
- Adds all to cart
- Calculates total for each product
- Shows grand total

**Tests:**
- ✅ Multi-product extraction
- ✅ Batch cart operations
- ✅ Total calculation
- ✅ Order confirmation format

---

#### Scenario 2.4: Context-Based Ordering
```
Message 1: "price of 8x80"
Bot: [Returns price with quote]
Message 2: "add 10 cartons"
```
**Expected Behavior:**
- Remembers previous product quoted (8x80)
- Associates quantity with quoted product
- Adds to cart without re-asking product
- Uses conversation memory

**Tests:**
- ✅ Conversation memory
- ✅ Context retrieval
- ✅ Quoted products tracking
- ✅ Smart order processing

---

### **Category 3: Customer Intelligence (Profile Reading)**

#### Scenario 3.1: Returning Customer Recognition
```
Message: "hi" (from phone number with purchase history)
```
**Expected Behavior:**
- Looks up customer profile by phone
- Retrieves purchase history
- Greets by name if available
- Mentions last order or regular products

**Tests:**
- ✅ Customer profile lookup
- ✅ Purchase history retrieval
- ✅ Personalized greeting
- ✅ Regular product identification

---

#### Scenario 3.2: Missing Regular Product Suggestion
```
Customer usually orders: 8x80, 8x100, 10x140
Message: "I need 8x80 5 cartons and 8x100 10 cartons"
```
**Expected Behavior:**
- AI checks product affinity table
- Detects missing regular product (10x140)
- Proactively suggests: "I notice you usually order 10x140 too. Would you like to add some?"

**Tests:**
- ✅ Product affinity analysis
- ✅ Missing product detection
- ✅ Proactive suggestion
- ✅ AI anomaly detection

---

#### Scenario 3.3: Personalized Pricing for VIP
```
Message: "price of 8x80" (from VIP customer with high lifetime value)
```
**Expected Behavior:**
- Recognizes VIP tier
- Shows special personalized price (lower than catalog)
- Highlights savings vs catalog price
- Adds VIP emoji or indicator

**Tests:**
- ✅ Customer tier recognition
- ✅ Personalized pricing retrieval
- ✅ Price comparison
- ✅ VIP handling

---

### **Category 4: Website Scraping & Knowledge Base**

#### Scenario 4.1: Company Information Query
```
Message: "tell me about your company"
```
**Expected Behavior:**
- Searches website_content table
- Finds "About Us" or company info
- Summarizes using AI
- Returns natural response

**Tests:**
- ✅ Website content search
- ✅ AI summarization
- ✅ Context retrieval
- ✅ Natural language generation

---

#### Scenario 4.2: Specific Product Category Info
```
Message: "what types of nylon anchors do you have?"
```
**Expected Behavior:**
- Searches products table + website content
- Finds category information
- Lists product variants
- Provides category description

**Tests:**
- ✅ Category search
- ✅ Product filtering by category
- ✅ Website content integration
- ✅ Comprehensive response

---

#### Scenario 4.3: Business Hours / Contact Info
```
Message: "what are your business hours?"
```
**Expected Behavior:**
- Searches website content or knowledge base
- Finds business hours from scraped pages
- Returns formatted response
- Fallback: checks tenant profile settings

**Tests:**
- ✅ Knowledge base search
- ✅ Structured data extraction
- ✅ Fallback logic
- ✅ Tenant settings retrieval

---

#### Scenario 4.4: Product Info (DMS) + Follow-ups (Non-hardcoded)
```
Message 1: "do you have DMS"
Message 2: "give me more details"
Message 3: "does it have workflow"
Message 4: "does it do multi document scanning"
```
**Expected Behavior:**
- Message 1:
   - Runs website retrieval for the tenant using the user question.
   - If the website context explicitly answers, returns an exact quote/snippet copied from the website context + a Source URL.
   - If no relevant website content exists, asks 1 short clarifying question (no guessing).
- Message 2:
   - Uses conversation memory to expand retrieval query (previous topic + follow-up), so the bot stays on the same product/topic.
   - Returns a longer exact snippet (still copied from website content) + Source URL when available.
- Message 3 and 4:
   - These are treated as “extra feature/spec” requests.
   - If the website explicitly confirms the feature, returns an exact quote + Source URL.
   - If the website does NOT explicitly confirm, responds with cautious/conditional language (no invented capabilities), asks 1–2 clarifying questions, and logs an `attention` follow-up for the dashboard.

**Dashboard Verification (for Message 3/4 when not explicitly answered):**
- A follow-up record is created with `status = attention` and includes the user request + the AI reply.

**Tests:**
- ✅ Retrieval-driven selection (no URL/product hardcoding)
- ✅ Follow-up topic continuity via conversation memory
- ✅ Verbatim website quoting when explicitly answered
- ✅ Feature/spec requests trigger `attention` logging when not explicitly covered

---

### **Category 5: Document Upload Processing**

#### Scenario 5.1: GST Certificate Upload
```
Action: Upload image of GST certificate
```
**Expected Behavior:**
- GPT-4 Vision analyzes image
- Extracts GST number
- Validates format
- Saves to customer profile
- Confirms extraction

**Tests:**
- ✅ Image processing
- ✅ OCR/Vision AI
- ✅ GST pattern extraction
- ✅ Validation
- ✅ Database update

---

#### Scenario 5.2: Product Catalog Upload (PDF/Excel)
```
Action: Upload Excel file with product list
```
**Expected Behavior:**
- Detects file type (spreadsheet)
- Parses columns
- Bulk imports products
- Returns summary of imported items
- Shows errors if any

**Tests:**
- ✅ File type detection
- ✅ Excel parsing
- ✅ Bulk database insert
- ✅ Error handling
- ✅ Import summary

---

#### Scenario 5.3: Purchase Order Document
```
Action: Upload PO document (image/PDF)
```
**Expected Behavior:**
- Extracts order details using AI
- Identifies products and quantities
- Creates order from document
- Asks for confirmation

**Tests:**
- ✅ Document OCR
- ✅ Structured data extraction
- ✅ Order creation
- ✅ Confirmation flow

---

### **Category 6: Advanced AI Features**

#### Scenario 6.1: Ambiguous Query Clarification
```
Message: "I want some screws"
```
**Expected Behavior:**
- Detects ambiguity (no quantity, vague product)
- Proactively asks clarification:
  - Which type of screws?
  - How many do you need?
- Provides examples/suggestions

**Tests:**
- ✅ Ambiguity detection
- ✅ Confidence scoring
- ✅ Proactive clarification
- ✅ Guided assistance

---

#### Scenario 6.2: Error Recovery
```
Message: "add 8x80 to cart"
Bot: [Cart update fails - database error]
```
**Expected Behavior:**
- Detects error
- Remembers context (product 8x80)
- Provides recovery options:
  1. Retry
  2. Try different product
  3. View cart
  4. Contact human
- Empathetic language

**Tests:**
- ✅ Error detection
- ✅ Context preservation
- ✅ Recovery strategies
- ✅ Human-like empathy

---

#### Scenario 6.3: Multi-turn Conversation
```
Message 1: "show me nylon anchors"
Bot: [Lists products]
Message 2: "which one is best for concrete?"
Bot: [Recommends specific variant]
Message 3: "okay, add 10 cartons of that"
Bot: [Adds recommended product]
```
**Expected Behavior:**
- Maintains conversation context
- Remembers "that" refers to recommended product
- Tracks conversation flow
- Natural multi-turn handling

**Tests:**
- ✅ Conversation memory
- ✅ Reference resolution ("that")
- ✅ Context continuity
- ✅ Natural dialogue

---

#### Scenario 6.4: Language Mixing (Code-Switching)
```
Message: "bhai 8x80 ka latest price batao na"
```
**Expected Behavior:**
- Detects Hinglish (Hindi + English)
- Responds in same mixed language
- Maintains professional tone
- Provides accurate information

**Tests:**
- ✅ Language detection
- ✅ Code-switching handling
- ✅ Natural response
- ✅ Tone consistency

---

## 🧪 **TESTING CHECKLIST**

### **Before Testing:**
- [ ] `.env` file configured with real credentials
- [ ] App running on correct port (8081 or configured PORT)
- [ ] Database connection verified
- [ ] OpenAI API key valid and has credits
- [ ] WhatsApp connection active (Desktop Agent or WAHA)
- [ ] Test phone number registered with a tenant

### **Database Verification:**
```sql
-- Check tenants
SELECT id, business_name, status, whatsapp_phone FROM tenants LIMIT 3;

-- Check products
SELECT COUNT(*) as total_products, 
       SUM(CASE WHEN is_active THEN 1 ELSE 0 END) as active_products
FROM products;

-- Check website content
SELECT COUNT(*) as pages_indexed FROM website_content;

-- Check knowledge base
SELECT COUNT(*) as documents_uploaded FROM knowledge_base_documents;

-- Check customers
SELECT COUNT(*) as total_customers FROM customer_profiles;
```

### **API Health Checks:**
```bash
# Health check
curl http://localhost:8081/_ah/health

# AI test
curl http://localhost:8081/api/debug/openai-test?prompt=ping

# Smart response preview (no WhatsApp send)
curl -X POST http://localhost:8081/api/test/preview-smart-response \
  -H "Content-Type: application/json" \
  -d '{"tenantId":"YOUR_TENANT_ID","phone":"1234567890","message":"price of 8x80"}'
```

---

## 📊 **EXPECTED AI METRICS**

### **Response Times:**
- Rule-based classification: **10-50ms**
- AI classification: **200-500ms**
- Database query: **50-200ms**
- AI response generation: **500-1500ms**
- **Total: 200-2000ms** (with cache: 200-800ms)

### **Accuracy Targets:**
- Intent classification: **92-95%**
- Product search: **85-90%**
- Entity extraction: **88-92%**
- Price accuracy: **100%**

### **Cost Per Test:**
- Rule-based: **$0.00**
- AI classification: **~$0.0001**
- AI response: **~$0.0008**
- **Total per message: $0.0006** (with cache)

---

## 🎨 **EXPECTED RESPONSE FORMATS**

### **Product Price Response:**
```
💰 **Nylon Frame Fixing 8x80**

✨ Your Special Price:
🔹 ₹1.45/pc per piece
📦 ₹1,450/carton
   (1000 pcs/carton)
💰 Saves ₹50 vs catalog

✅ To order, just say "add 10 cartons" or "I need 5 cartons"
```

### **Volume Discount Response:**
```
💰 **Price for 100,000 pieces of 10x100:**

🎉 **VOLUME DISCOUNT: 15% OFF**
~~₹2.00/pc~~ → **₹1.70/pc** per piece

📊 **Total Quote:**
   100,000 pcs × ₹1.70 = **₹1,70,000.00**
   (≈ 100 cartons)
   💰 You save: ₹30,000.00 (15% off)

🛒 Ready to order? Just say 'yes' or 'add to cart'!
```

### **Multi-Product Response:**
```
💰 **Price Information:**

📦 **Nylon Anchor 8x80**
🔹 ₹1.50/pc per piece
📦 ₹1,500/carton (1000 pcs)
📊 Quote for 5 cartons: **₹7,500.00**

📦 **Nylon Anchor 8x100**
🔹 ₹1.80/pc per piece
📦 ₹1,800/carton (1000 pcs)
📊 Quote for 10 cartons: **₹18,000.00**

━━━━━━━━━━━━━━━━━━━━
📋 **Total Summary:**
   15 cartons total
   Grand Total: ₹25,500.00

🛒 Ready to place this order? Just say 'yes' or 'add to cart'!
```

---

## 🚀 **NEXT STEPS**

1. **Configure `.env` file** with your actual credentials
2. **Start the app:** `npm start`
3. **Verify health:** Check http://localhost:8081/_ah/health
4. **Start with basic tests:** Try "hi" then "price of 8x80"
5. **Progress to advanced:** Multi-product orders, volume discounts
6. **Test AI features:** Ambiguity handling, context memory
7. **Check documents:** Upload GST certificate or product catalog
8. **Monitor costs:** Check AI usage and costs after testing

---

## 📝 **TESTING LOG TEMPLATE**

```
Test Date: December 28, 2025
Tester: [Your Name]
Tenant ID: [Your Tenant]
Test Phone: [Test Number]

| Scenario | Message Sent | Response Time | AI Used? | Accuracy | Pass/Fail | Notes |
|----------|--------------|---------------|----------|----------|-----------|-------|
| 1.1      | "price of 8x80" | 450ms | Yes | 100% | ✅ Pass | Perfect |
| 1.2      | "8x80, 8x100" | 680ms | Yes | 100% | ✅ Pass | Good format |
| 2.1      | "I need 10 cartons" | 520ms | Yes | 100% | ✅ Pass | Cart updated |
| ...      | ...          | ...    | ...  | ...  | ...       | ...    |
```

---

**STATUS:** ⚠️ **SETUP REQUIRED BEFORE TESTING**

Once you configure the `.env` file and start the app properly, come back to this document and execute the test scenarios in order!
