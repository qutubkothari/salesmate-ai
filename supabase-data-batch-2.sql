-- ============================================
-- Data Migration SQL
-- Generated: 2026-01-20T02:40:52.006Z
-- ============================================


-- Data for: inbound_messages (20 rows)
INSERT INTO inbound_messages (id, tenant_id, from_phone, body, received_at, message_id) VALUES
  ('2f7123ef60e60ea4fbccc39c95524c04', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'Hi', '2026-01-10T10:58:33.031Z', '2AB609295B8F8170A3FA'),
  ('2eb74441dbedf61150bd59ba85ccfd05', '101f04af63cbefc2bf8f0a98b9ae1205', '120363159595270288', '📢 Notice to all Hatimi Hills residents 
Phase -I

New owners ( 2nd owners)  kindly submit a copy of the sales deed to the society office within 3 days . 
This copy is required for the Society Formation work to be processed.


Thank you,
Team HH 1', '2026-01-10T11:14:59.347Z', 'AC98A987CF803D845812DB4732C1D7C5'),
  ('728b69e2504fb0d5f2fead59c23e020e', '101f04af63cbefc2bf8f0a98b9ae1205', '919537653927', 'Hi', '2026-01-11T16:37:10.516Z', '3A7C73B595753AC54D96'),
  ('705bf043203b2ec15b888f791c79fe3d', '101f04af63cbefc2bf8f0a98b9ae1205', '919537653927', 'tell me more about your products', '2026-01-11T18:54:48.585Z', '3A06ACF7502A152CC055'),
  ('6cbac3a1ae5954dcc00344c9f8440107', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'hello', '2026-01-12T11:26:14.363Z', '3EB09691B83B02235C7256'),
  ('684f1dc853c59b9676514dddbb513589', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'hi', '2026-01-12T11:34:07.623Z', '3EB0665D92CF55EF0CF67C'),
  ('de840a9926cb3a85ad441b89b334f37f', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'i want to develop a bot', '2026-01-12T11:34:30.970Z', '3EB0EF3E27D5034FDBE1E7'),
  ('36d976d8bc4ead6755cb32a133af569f', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'for my sales team', '2026-01-12T11:35:01.706Z', '3EB090E3F7EEBDC9B3A629'),
  ('f7bb6652dab3e5270165e35b7f24e51e', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'i want to develop a bot', '2026-01-12T12:23:56.114Z', '3EB09A27CE84C84DB913CC'),
  ('75d246a52279d85630b41f12dcda79e9', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'does your software scan arabic documents also ?', '2026-01-12T14:22:31.407Z', '3EB0E013E4B99961370CDE'),
  ('142e48c61cc16c8a544d3ad7f784e00a', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'does your software scan arabic documents also ?', '2026-01-12T15:10:43.861Z', '3EB0F35EED9AACE7F37E2F'),
  ('9cd8e8fd2f5733afce25add9589a3293', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'does your software scan arabic documents also ?', '2026-01-12T15:19:24.959Z', '3EB055BCC1742F2BB698BD'),
  ('5bb40090bf010c6f64cce589cd1f1b14', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'does your software scan arabic documents also ?', '2026-01-12T17:01:32.682Z', '3EB0688DF7BEBFE33247EF'),
  ('8a1922b1e43f660a2d06bd4409f49649', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'does your software scan arabic documents also ?', '2026-01-12T17:08:02.594Z', '3EB099B33FC89F85640820'),
  ('7a38c08d65a392f2092b7c8bbfbbd050', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'does your software scan arabic documents also ?', '2026-01-12T17:11:06.698Z', '3EB08592021CA00B7A4816'),
  ('dc57f79261f3cad4772cab139745eef8', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'does your software scan arabic documents also ?', '2026-01-12T17:21:10.175Z', '3EB07F42C98AC850AFC05F'),
  ('c7f8c14cae30c9a6a623664defe57186', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'gve me more details about your software', '2026-01-12T17:21:41.800Z', '3EB06D0C32796A55C08018'),
  ('a6f00468c93f6c5f0dffc437d4957b6c', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'do you have document management system', '2026-01-12T17:56:33.121Z', '3EB09BBF1B6BE3A373DB5E'),
  ('786f050fd02a104b5bc724f585cacda7', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'do you have document management system', '2026-01-12T18:04:07.428Z', '3EB0945FF87BC2FD8EB930'),
  ('c268c2a63f02f0a2d79050ea7043958f', '101f04af63cbefc2bf8f0a98b9ae1205', '971507055253', 'do you have document management system', '2026-01-12T18:11:10.141Z', '3EB07649BD52FF6182DC6B')
ON CONFLICT DO NOTHING;



-- Data for: lead_events (4 rows)
INSERT INTO lead_events (id, tenant_id, event_type, lead_id, conversation_id, triggered_by, payload, created_at) VALUES
  (1, '101f04af63cbefc2bf8f0a98b9ae1205', 'HEAT_CHANGED', NULL, '570a6aa56da9196b27ae1e7597160600', 'SYSTEM_AI', '{"old_heat":"COLD","new_heat":"HOT","confidence":0.7,"reasons":["arabic documents","scan"]}', '2026-01-12 15:10:45'),
  (2, '101f04af63cbefc2bf8f0a98b9ae1205', 'HEAT_CHANGED', NULL, '570a6aa56da9196b27ae1e7597160600', 'SYSTEM_AI', '{"old_heat":"HOT","new_heat":"WARM","confidence":0.6,"reasons":["Arabic documents"]}', '2026-01-12 15:19:26'),
  (3, '101f04af63cbefc2bf8f0a98b9ae1205', 'HEAT_CHANGED', NULL, '570a6aa56da9196b27ae1e7597160600', 'SYSTEM_AI', '{"old_heat":"WARM","new_heat":"HOT","confidence":0.8,"reasons":["Arabic documents","scan"]}', '2026-01-12 17:21:11'),
  (4, '101f04af63cbefc2bf8f0a98b9ae1205', 'HEAT_CHANGED', NULL, '570a6aa56da9196b27ae1e7597160600', 'SYSTEM_AI', '{"old_heat":"HOT","new_heat":"WARM","confidence":0.6,"reasons":["document management system"]}', '2026-01-12 17:56:34')
ON CONFLICT DO NOTHING;



-- Data for: lead_pipeline_items (1 rows)
INSERT INTO lead_pipeline_items (id, tenant_id, conversation_id, stage_id, created_at, updated_at) VALUES
  ('a27e114afb0e34f2852277e051767501', 'a49000aba12f9d71921c22dc5a36cdf0', '7c04f0ddec6dc1d085d30c16e99bbe8b', 'aaca14cf86dd2dceb23b855d8e5f23f2', '2026-01-09T13:20:00.188Z', '2026-01-09T13:20:00.188Z')
ON CONFLICT DO NOTHING;



-- Data for: lead_pipeline_stages (12 rows)
INSERT INTO lead_pipeline_stages (id, tenant_id, name, position, is_won, is_lost, created_at, updated_at) VALUES
  ('935a69deb9f331d3795c2351e4a54ebc', 'a49000aba12f9d71921c22dc5a36cdf0', 'New', 1, 0, 0, '2026-01-09T13:09:59.247Z', '2026-01-09T13:09:59.247Z'),
  ('aaca14cf86dd2dceb23b855d8e5f23f2', 'a49000aba12f9d71921c22dc5a36cdf0', 'Qualified', 2, 0, 0, '2026-01-09T13:09:59.247Z', '2026-01-09T13:09:59.247Z'),
  ('60d37a266e4f423e0b27348e84e64157', 'a49000aba12f9d71921c22dc5a36cdf0', 'Won', 3, 1, 0, '2026-01-09T13:09:59.247Z', '2026-01-09T13:09:59.247Z'),
  ('db0231fd545c904417088f7a67805276', 'a49000aba12f9d71921c22dc5a36cdf0', 'Lost', 4, 0, 1, '2026-01-09T13:09:59.247Z', '2026-01-09T13:09:59.247Z'),
  ('91145b81ebd24389be9013d9bfd5c994', 'tenant_test_123', 'New', 1, 0, 0, '2026-01-09T13:13:11.771Z', '2026-01-09T13:13:11.771Z'),
  ('49ba9fc80764b16ff6ebe5378621a362', 'tenant_test_123', 'Qualified', 2, 0, 0, '2026-01-09T13:13:11.771Z', '2026-01-09T13:13:11.771Z'),
  ('69aca8d5c02448e49d50ddeb44b842fb', 'tenant_test_123', 'Won', 3, 1, 0, '2026-01-09T13:13:11.771Z', '2026-01-09T13:13:11.771Z'),
  ('c5fc96d9a66ee59ed30a585fc9d60479', 'tenant_test_123', 'Lost', 4, 0, 1, '2026-01-09T13:13:11.771Z', '2026-01-09T13:13:11.771Z'),
  ('7e4344a1cfde162d75906e72c14de056', '101f04af63cbefc2bf8f0a98b9ae1205', 'New', 1, 0, 0, '2026-01-10T10:33:52.145Z', '2026-01-10T10:33:52.145Z'),
  ('f56b42471eb043c76736bb15ef778ac3', '101f04af63cbefc2bf8f0a98b9ae1205', 'Qualified', 2, 0, 0, '2026-01-10T10:33:52.145Z', '2026-01-10T10:33:52.145Z'),
  ('c86cd59dfebe226c241b6868d6aa854f', '101f04af63cbefc2bf8f0a98b9ae1205', 'Won', 3, 1, 0, '2026-01-10T10:33:52.145Z', '2026-01-10T10:33:52.145Z'),
  ('2612d1f2c048ba562e1eab71044e1e50', '101f04af63cbefc2bf8f0a98b9ae1205', 'Lost', 4, 0, 1, '2026-01-10T10:33:52.145Z', '2026-01-10T10:33:52.145Z')
ON CONFLICT DO NOTHING;



-- Data for: messages (81 rows)
INSERT INTO messages (id, tenant_id, conversation_id, sender, message_body, message_type, created_at, whatsapp_message_id) VALUES
  ('0682560ab7b676b66e30fbfa5665869c', NULL, 'c8558f9935db6848ba5e749036b5c342', 'user', 'I want to place order for 10 cartons. Please send payment link now.', 'user_input', '2026-01-09T04:38:14.638Z', NULL),
  ('a74c05eb233f31f48f0618555f1e6a6b', 'a49000aba12f9d71921c22dc5a36cdf0', 'c8558f9935db6848ba5e749036b5c342', 'bot', 'An error occurred during checkout. Please try again.', 'bot_response', '2026-01-09T04:38:14.650Z', 'desktop_agent_captured_1767933494650'),
  ('567f18148b5ae022796900f9f2bcc57a', NULL, '7c04f0ddec6dc1d085d30c16e99bbe8b', 'user', 'I want to speak with a human agent.', 'user_input', '2026-01-09T04:40:57.930Z', NULL),
  ('e61fd9e7230efabe116a733a975c7f59', 'a49000aba12f9d71921c22dc5a36cdf0', '7c04f0ddec6dc1d085d30c16e99bbe8b', 'bot', 'I''ve connected you with our sales team for personalized assistance. A team member will contact you shortly to help with your specific requirements. Thank you for your patience! 🙏', 'handover_response', '2026-01-09 04:40:57', NULL),
  ('f7d8664f5725df16089cd794b060a718', 'a49000aba12f9d71921c22dc5a36cdf0', '7c04f0ddec6dc1d085d30c16e99bbe8b', 'bot', 'I''ve connected you with our sales team for personalized assistance. A team member will contact you shortly to help with your specific requirements. Thank you for your patience! 🙏', 'bot_response', '2026-01-09T04:40:57.966Z', 'desktop_agent_captured_1767933657966'),
  ('cdd640bd5044aabdab6b92820d0eddf5', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Bags
Products', 'user_input', '2026-01-10T10:54:37.742Z', NULL),
  ('88d805da1a1bd37beda4fb09f0a58677', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', '"Rate Enquiries?

For any product rates, kindly send a direct message to 8356862623.

We''ll be happy to assist you!"', 'user_input', '2026-01-10T10:54:37.819Z', NULL),
  ('b500d4ca87a321eeaba4dd4281c4627b', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Follow this link to join my WhatsApp community: https://chat.whatsapp.com/BL23YptLaC76OxEtMhIZa3

*FURTHER ALL PRODUCTS WILL BE UPDATED IN COMMUNITY  ONLY BROADCAST HAS BEEN STOPPED*

*FOR ORDER & QUERY RELATED YOU CAN CONTACT US ON 8356862623*', 'user_input', '2026-01-10T10:54:37.819Z', NULL),
  ('b34be147e5ba09818486819ce1320ba6', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:39.556Z', 'desktop_agent_captured_1768042479556'),
  ('250c995aabe4ce4cbcffe986e73d7489', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:39.653Z', 'desktop_agent_captured_1768042479653'),
  ('3670c81867f6ff8e1368db0bf11df3d2', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Stock available 💥💥💥', 'user_input', '2026-01-10T10:54:39.985Z', NULL),
  ('9096b2ada6e1c23668b20759e08a5bb4', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:40.634Z', 'desktop_agent_captured_1768042480634'),
  ('ac7106200df35f8315cb4ddaf45b0dfb', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'US Supreme Court Delays Ruling on Trump Tariffs Case', 'user_input', '2026-01-10T10:54:41.482Z', NULL),
  ('4d869b52533d67865da6f6151fdbbcfe', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Happy birthday dear simarn 😘🎂🎂🎂🎂', 'user_input', '2026-01-10T10:54:41.518Z', NULL),
  ('72d6eabc2969cc850b187f159e2d6e48', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Household 
Products', 'user_input', '2026-01-10T10:54:41.541Z', NULL),
  ('6f97854e30ae30873b0b3a903126450b', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Follow this link to join my WhatsApp community: https://chat.whatsapp.com/BL23YptLaC76OxEtMhIZa3

*FURTHER ALL PRODUCTS WILL BE UPDATED IN COMMUNITY  ONLY BROADCAST HAS BEEN STOPPED*

*FOR ORDER & QUERY RELATED YOU CAN CONTACT US ON 8356862623*', 'user_input', '2026-01-10T10:54:41.542Z', NULL),
  ('f912d075472823574816583240f82ba8', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', '😄', 'user_input', '2026-01-10T10:54:41.861Z', NULL),
  ('e1f66d10b7c2bfa0b27a0a3b1437693c', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', '🙏', 'user_input', '2026-01-10T10:54:41.903Z', NULL),
  ('d727efb0f389a14593f416afee266b06', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', '🏡 ❤️', 'user_input', '2026-01-10T10:54:41.963Z', NULL),
  ('7a79650528a1663a92ab1a603e9fe1bf', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:42.528Z', 'desktop_agent_captured_1768042482528'),
  ('99ff180d910c77f69a546f28be96d330', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Contact details for veggies', 'user_input', '2026-01-10T10:54:42.592Z', NULL),
  ('5b70af9a31bb8c35342473d9e58c0c37', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', '🥳', 'user_input', '2026-01-10T10:54:42.618Z', NULL),
  ('546bb7ef02a25dce13d3acdb356c087d', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'https://music.youtube.com/watch?v=YBGKwMAtdHI&si=8YUTBAZ4jrRigUE6', 'user_input', '2026-01-10T10:54:42.653Z', NULL),
  ('c0437d8a300e67e3f03f1794dce1a4db', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Order on http://dandoosh.dotpe.in', 'user_input', '2026-01-10T10:54:42.754Z', NULL),
  ('fae952c7d2a9e92c2866a4e8f88ab836', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Order on http://dandoosh.dotpe.in', 'user_input', '2026-01-10T10:54:42.799Z', NULL),
  ('dc3900c8718c2ae09a2a1afbf1df1551', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Order on http://dandoosh.dotpe.in', 'user_input', '2026-01-10T10:54:42.800Z', NULL),
  ('4efc002fe32ad918c0895d2ba78c5edf', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'user', 'Order on http://dandoosh.dotpe.in', 'user_input', '2026-01-10T10:54:42.800Z', NULL),
  ('1da9ac219dab0f6cb45cdf339e4f0887', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:43.096Z', 'desktop_agent_captured_1768042483096'),
  ('6f15cc3cca53f0df66f3d0efc7375e19', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:43.131Z', 'desktop_agent_captured_1768042483131'),
  ('09a5703ff82d3b0b9b45677d4d8c1a98', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:43.219Z', 'desktop_agent_captured_1768042483219'),
  ('47ef4cdda2329b05ebeff0d76db0d52e', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:43.339Z', 'desktop_agent_captured_1768042483339'),
  ('eeff066346ab7d24b44d1cfcebe59db9', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:43.484Z', 'desktop_agent_captured_1768042483484'),
  ('7050cd917b224b225ec7f8a535cd5e53', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:43.508Z', 'desktop_agent_captured_1768042483508'),
  ('5d02054c20de56cd729d7e06484aeaad', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:43.587Z', 'desktop_agent_captured_1768042483587'),
  ('bec0f525497ade4fd74d34613065811a', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:44.181Z', 'desktop_agent_captured_1768042484181'),
  ('813f5f3eee1ea12454dbdea6fd4ee56a', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:44.315Z', 'desktop_agent_captured_1768042484314'),
  ('2cab9fe426eb7f4f84c3d25a23a99257', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:44.411Z', 'desktop_agent_captured_1768042484409'),
  ('9e82f9158eb97288bba5cbb37ea919de', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:44.466Z', 'desktop_agent_captured_1768042484466'),
  ('e8761f9fcac620a41ea6edac2d44b6f5', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:44.486Z', 'desktop_agent_captured_1768042484483'),
  ('7332b01c4105386cf4b0bba4a16b4aee', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:44.550Z', 'desktop_agent_captured_1768042484550'),
  ('943a22b7db342d89beb7e243f590a4fe', '101f04af63cbefc2bf8f0a98b9ae1205', '75dd4d030bfa19f3ac8d29672246de92', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T10:54:45.178Z', 'desktop_agent_captured_1768042485178'),
  ('9895067b5323caf7c5718c7f38338c5a', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'Hi', 'user_input', '2026-01-10T10:58:33.048Z', NULL),
  ('2b95b834a390db38bf910e3cd8bfbac1', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'Hi! How can I help you today?

You can say things like:
1. "Show me your products"
2. "Price of <product name>"
3. "Add <product> 2 cartons"
4. "View my cart"', 'bot_response', '2026-01-10T10:58:33.794Z', 'desktop_agent_captured_1768042713794'),
  ('69f16b06b1ece074fd45888afa28bf9d', '101f04af63cbefc2bf8f0a98b9ae1205', '37f36ac3d2ceec7b60992385ba727e4a', 'user', '📢 Notice to all Hatimi Hills residents 
Phase -I

New owners ( 2nd owners)  kindly submit a copy of the sales deed to the society office within 3 days . 
This copy is required for the Society Formation work to be processed.


Thank you,
Team HH 1', 'user_input', '2026-01-10T11:14:59.375Z', NULL),
  ('f885edfce21bf0f4a17c792c155921c5', '101f04af63cbefc2bf8f0a98b9ae1205', '37f36ac3d2ceec7b60992385ba727e4a', 'bot', 'I want to help, but I''m not sure what you''d like to do.

Would you like to:
1. Add a product to cart
2. Check product prices
3. View your cart
4. Place an order', 'bot_response', '2026-01-10T11:15:01.363Z', 'desktop_agent_captured_1768043701363'),
  ('8cbafd9da414963f27f28318b4204780', '101f04af63cbefc2bf8f0a98b9ae1205', 'c5351a3d928e382fb48984d97682dc08', 'user', 'Hi', 'user_input', '2026-01-11T16:37:10.542Z', NULL),
  ('0058f0c490f47e6a92d62e03366eb1a6', '101f04af63cbefc2bf8f0a98b9ae1205', 'c5351a3d928e382fb48984d97682dc08', 'bot', 'Hi! How can I help you today?

You can say things like:
1. "Show me your products"
2. "Price of <product name>"
3. "Add <product> 2 cartons"
4. "View my cart"', 'bot_response', '2026-01-11T16:37:16.655Z', 'desktop_agent_captured_1768149436655'),
  ('f5a755069e89b840fb7b7b55454d7454', '101f04af63cbefc2bf8f0a98b9ae1205', 'c5351a3d928e382fb48984d97682dc08', 'user', 'tell me more about your products', 'user_input', '2026-01-11T18:54:48.604Z', NULL),
  ('56d6b8c1d1d230133620e4dc80963866', '101f04af63cbefc2bf8f0a98b9ae1205', 'c5351a3d928e382fb48984d97682dc08', 'bot', 'ðŸ“„ Here''s information from our website:

*WhatsApp Automation Tool & AI Chatbot for Business | 24/7 Sales, Support, Orders & Pricing | Salesmate*
SAK WhatsApp AI Sales Assistant About Features AI Assistant Intent, FAQs, product answers Orders Create & manage orders Products Catalog, pricing, search Follow-ups Lead tracking & reminders Customers Profiles, GST, addresses Broadcasts Campaign messaging Documents Policy & FAQ knowledge Website Ind...

ðŸ”— https://salesmate.saksolution.com/

*SAK Feature: Products*
SAK WhatsApp AI Sales Assistant Features Login Home / Features / Products Products Manage your product catalog, SKUs, pricing, and categories so the AI can quote accurately and the team can operate from one source of truth. What it does Products is your catalog management hub. It’s designed to suppo...

ðŸ”— https://salesmate.saksolution.com/features/products.html

*SAK Feature: AI Assistant*
SAK WhatsApp AI Sales Assistant Features Login Home / Features / AI Assistant AI Assistant Your WhatsApp-first AI that understands intent, answers from your catalog + knowledge sources, and guides customers toward checkout. Intent understanding Product-aware answers Docs + website knowledge What it ...

ðŸ”— https://salesmate.saksolution.com/features/ai-assistant.html

', 'bot_response', '2026-01-11T18:55:01.290Z', 'desktop_agent_captured_1768157701290'),
  ('bba873b1f774b57ed4a6fe37e0afd1e1', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'hello', 'user_input', '2026-01-12T11:26:14.411Z', NULL),
  ('746be949c262da44876aa2909cf9e0ba', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'Hi! How can I help you today?

You can say things like:
1. "Show me your products"
2. "Price of <product name>"
3. "Add <product> 2 cartons"
4. "View my cart"', 'bot_response', '2026-01-12T11:26:20.874Z', 'desktop_agent_captured_1768217180874'),
  ('8cb6dd22ffc917d36ba4570be0b5d9c9', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'hi', 'user_input', '2026-01-12T11:34:07.634Z', NULL),
  ('1f0b82c462bdb0d1dbb7000c49424380', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'Hello! How can I assist you today?', 'bot_response', '2026-01-12T11:34:18.300Z', 'desktop_agent_captured_1768217658300'),
  ('0dc074fbef2a30217373437e6b58e8f9', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'i want to develop a bot', 'user_input', '2026-01-12T11:34:30.982Z', NULL),
  ('c87387be8bbfa31f8c7555d0534e91a1', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'That sounds like an exciting project! What kind of bot are you looking to develop? For instance, is it a chatbot for customer service, a social media bot, or something else? Let me know, and I’d be happy to help with ideas, tools, or resources!', 'bot_response', '2026-01-12T11:34:43.152Z', 'desktop_agent_captured_1768217683152'),
  ('cdeda67aed7cc0772e464253508116e9', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'for my sales team', 'user_input', '2026-01-12T11:35:01.720Z', NULL),
  ('b7b6daada00ca79bfa2ee9385d3ee9fa', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'Of course! What specific information or support do you need for your sales team? Whether it''s tips on improving sales strategies, managing leads, or team motivation, I’m here to help!', 'bot_response', '2026-01-12T11:35:13.051Z', 'desktop_agent_captured_1768217713051'),
  ('aaa6557f094eb62cdd79bcd0ad4689c6', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'i want to develop a bot', 'user_input', '2026-01-12T12:23:56.123Z', NULL),
  ('002dd0c80e6a987c94021f235a6bf0e7', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'That sounds like an exciting project! Developing a bot can be a fun way to learn new skills and automate tasks. Do you have a specific type of bot in mind? For example, are you thinking about a chatbot for customer service, a social media bot, or something else entirely? I’d love to help you with resources or guidance on how to get started!', 'bot_response', '2026-01-12T12:24:09.181Z', 'desktop_agent_captured_1768220649181'),
  ('0b3886dd5f525554287dd4c2f6de5e63', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'does your software scan arabic documents also ?', 'user_input', '2026-01-12T14:22:31.424Z', NULL),
  ('d3df4c5de1049fedeafb3c88ec7165fd', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'ðŸ¢ We are a leading supplier with 10+ years experience. Quality guaranteed on all products.', 'bot_response', '2026-01-12T14:22:45.438Z', 'desktop_agent_captured_1768227765438'),
  ('d9903ef865a76cf119999aaf22d78085', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'does your software scan arabic documents also ?', 'user_input', '2026-01-12T15:10:43.897Z', NULL),
  ('98e08ebddfd265cfaea640a76111f252', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'I''m sorry, but I encountered an error while trying to process your request. Please try again later.', 'bot_response', '2026-01-12T15:11:00.223Z', 'desktop_agent_captured_1768230660223'),
  ('48af67a8f0b285b6c26128f06061595f', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'does your software scan arabic documents also ?', 'user_input', '2026-01-12T15:19:24.973Z', NULL),
  ('a73e44b1261442c39d152c3b8a299e29', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'ðŸ¢ We are a leading supplier with 10+ years experience. Quality guaranteed on all products.', 'bot_response', '2026-01-12T15:19:43.930Z', 'desktop_agent_captured_1768231183930'),
  ('682b76ea14b39f861bf5f9a0b1f0c80b', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'does your software scan arabic documents also ?', 'user_input', '2026-01-12T17:01:32.725Z', NULL),
  ('25015d1ff4f48a80ed7d97404f91598c', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'ðŸ¢ We are a leading supplier with 10+ years experience. Quality guaranteed on all products.', 'bot_response', '2026-01-12T17:01:57.726Z', 'desktop_agent_captured_1768237317726'),
  ('9d0b5e52a6e2107a106f2add79cd380b', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'does your software scan arabic documents also ?', 'user_input', '2026-01-12T17:08:02.609Z', NULL),
  ('4972cacc94c394b88943a4079b927662', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'I don''t have specific information about that. Let me connect you with our team for details.', 'bot_response', '2026-01-12T17:08:16.754Z', 'desktop_agent_captured_1768237696754'),
  ('ff86954b37f07961642f5f4f9b067019', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'does your software scan arabic documents also ?', 'user_input', '2026-01-12T17:11:06.711Z', NULL),
  ('dde0522384a087157ee8cba694facce7', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'I''m sorry, but I don''t have specific information regarding whether our software can scan Arabic documents. If you have any other questions or need assistance, feel free to ask!', 'bot_response', '2026-01-12T17:11:22.122Z', 'desktop_agent_captured_1768237882122'),
  ('965c6338cca8a55a8b02b9fa9d38edc2', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'does your software scan arabic documents also ?', 'user_input', '2026-01-12T17:21:10.185Z', NULL),
  ('8e6b46a24f4f8074ea79a71d52c4005a', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'Yes, our software supports processing Arabic documents. With our multilingual support, you can upload and process documents in Arabic along with other languages. If you have any more questions or need further assistance, feel free to ask!', 'bot_response', '2026-01-12T17:21:22.102Z', 'desktop_agent_captured_1768238482101'),
  ('b6c39a56980430a60d55035fe6b16810', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'gve me more details about your software', 'user_input', '2026-01-12T17:21:41.807Z', NULL),
  ('0e8ae7e24a4ddda28d6aefa1ce4bceb5', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'Sure! Our software offers several key capabilities:

1. **Document Processing**: You can upload and process various documents, including PDFs, policies, and FAQs, which helps our AI assist you better.

2. **Multilingual Support**: We support multiple languages, including Arabic, making it suitable for businesses in the Middle East and other regions.

3. **AI Assistant**: Our AI is powered by OpenAI and is designed to understand customer intent and context, allowing for effective communication.

4. **Product Catalog**: You can access a searchable product catalog with detailed information, pricing, and variants.

5. **Order Management**: Our platform handles orders and cart management directly through chat, streamlining the purchasing process.

6. **Integrations**: We support integrations with various tools like Zoho, Google Sheets, Calendly, Shopify, and more, enhancing functionality and efficiency.

If you have any specific questions about a feature or need further details, feel free to ask!', 'bot_response', '2026-01-12T17:21:59.047Z', 'desktop_agent_captured_1768238519047'),
  ('33f26c5975c096679adb51e0f369040e', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'do you have document management system', 'user_input', '2026-01-12T17:56:33.137Z', NULL),
  ('930f446647bdf1b87becd3e8ac379b1a', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'I''m sorry, but I don''t have specific information regarding whether we offer a document management system. If you have any other questions or need assistance with something else, feel free to ask!', 'bot_response', '2026-01-12T17:56:49.760Z', 'desktop_agent_captured_1768240609760'),
  ('6dbf2d39ee282fa0ed113f6bc480260c', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'do you have document management system', 'user_input', '2026-01-12T18:04:07.451Z', NULL),
  ('ffeaa34b6af85ebe0de8b37fbc067a10', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'I''m sorry, but I don''t have specific information regarding whether we offer a document management system. If you have any other questions or need assistance with something else, please let me know!', 'bot_response', '2026-01-12T18:04:24.371Z', 'desktop_agent_captured_1768241064371'),
  ('dd9e6906b585c45d747efe87987d4f1f', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'user', 'do you have document management system', 'user_input', '2026-01-12T18:11:10.152Z', NULL),
  ('fa4ce1234dbf4e7b18dddc250bd598d7', '101f04af63cbefc2bf8f0a98b9ae1205', '570a6aa56da9196b27ae1e7597160600', 'bot', 'I''m sorry, but I don''t have specific information regarding whether we offer a document management system. If you have any other questions or need assistance with something else, please let me know!', 'bot_response', '2026-01-12T18:11:24.157Z', 'desktop_agent_captured_1768241484157')
ON CONFLICT DO NOTHING;



-- Data for: permission_audit_log (2 rows)
INSERT INTO permission_audit_log (id, tenant_id, user_id, action, target_user_id, role_id, permission_id, resource_type, resource_id, details, ip_address, user_agent, created_at) VALUES
  ('cd1275dafe0b3ea92c4d145fa6572759', '101f04af63cbefc2bf8f0a98b9ae1205', 'system', 'role_assigned', 'b8a48b98-8bba-4382-b024-6c1a35038f39', '16ecbeff80b982f4c38bd71440c62f59', NULL, NULL, NULL, '{"roleId":"16ecbeff80b982f4c38bd71440c62f59","expiresAt":null}', NULL, NULL, '2026-01-18 06:39:43'),
  ('c0fe573cfad94e5c627e2654b2bb1e7a', '101f04af63cbefc2bf8f0a98b9ae1205', 'system', 'role_assigned', 'b8a48b98-8bba-4382-b024-6c1a35038f39', '4b7ab1e54d1d97068de39a8d5d481b51', NULL, NULL, NULL, '{"roleId":"4b7ab1e54d1d97068de39a8d5d481b51","expiresAt":null}', NULL, NULL, '2026-01-18 06:39:43')
ON CONFLICT DO NOTHING;



-- Data for: permissions (33 rows)
INSERT INTO permissions (id, permission_code, permission_name, resource, action, description, created_at) VALUES
  ('perm_products_create', 'products.create', 'Create Products', 'products', 'create', 'Add new products to catalog', '2026-01-18 06:38:33'),
  ('perm_products_read', 'products.read', 'View Products', 'products', 'read', 'View product information', '2026-01-18 06:38:33'),
  ('perm_products_update', 'products.update', 'Update Products', 'products', 'update', 'Modify product details', '2026-01-18 06:38:33'),
  ('perm_products_delete', 'products.delete', 'Delete Products', 'products', 'delete', 'Remove products from catalog', '2026-01-18 06:38:33'),
  ('perm_products_export', 'products.export', 'Export Products', 'products', 'export', 'Export product data', '2026-01-18 06:38:33'),
  ('perm_orders_create', 'orders.create', 'Create Orders', 'orders', 'create', 'Place new orders', '2026-01-18 06:38:33'),
  ('perm_orders_read', 'orders.read', 'View Orders', 'orders', 'read', 'View order information', '2026-01-18 06:38:33'),
  ('perm_orders_update', 'orders.update', 'Update Orders', 'orders', 'update', 'Modify order status', '2026-01-18 06:38:33'),
  ('perm_orders_delete', 'orders.delete', 'Cancel Orders', 'orders', 'delete', 'Cancel orders', '2026-01-18 06:38:33'),
  ('perm_orders_approve', 'orders.approve', 'Approve Orders', 'orders', 'approve', 'Approve order discounts', '2026-01-18 06:38:33'),
  ('perm_customers_create', 'customers.create', 'Create Customers', 'customers', 'create', 'Add new customers', '2026-01-18 06:38:33'),
  ('perm_customers_read', 'customers.read', 'View Customers', 'customers', 'read', 'View customer information', '2026-01-18 06:38:33'),
  ('perm_customers_update', 'customers.update', 'Update Customers', 'customers', 'update', 'Modify customer details', '2026-01-18 06:38:33'),
  ('perm_customers_delete', 'customers.delete', 'Delete Customers', 'customers', 'delete', 'Remove customers', '2026-01-18 06:38:33'),
  ('perm_customers_export', 'customers.export', 'Export Customers', 'customers', 'export', 'Export customer data', '2026-01-18 06:38:33'),
  ('perm_pricing_view', 'pricing.view', 'View Pricing', 'pricing', 'read', 'View standard pricing', '2026-01-18 06:38:33'),
  ('perm_pricing_manage', 'pricing.manage', 'Manage Pricing', 'pricing', 'update', 'Manage pricing tiers and rules', '2026-01-18 06:38:33'),
  ('perm_pricing_override', 'pricing.override', 'Override Pricing', 'pricing', 'override', 'Set custom prices', '2026-01-18 06:38:33'),
  ('perm_pricing_approve', 'pricing.approve', 'Approve Pricing', 'pricing', 'approve', 'Approve price changes', '2026-01-18 06:38:33'),
  ('perm_reports_view', 'reports.view', 'View Reports', 'reports', 'read', 'Access reports and dashboards', '2026-01-18 06:38:33'),
  ('perm_reports_export', 'reports.export', 'Export Reports', 'reports', 'export', 'Export report data', '2026-01-18 06:38:33'),
  ('perm_analytics_advanced', 'analytics.advanced', 'Advanced Analytics', 'analytics', 'read', 'Access advanced analytics', '2026-01-18 06:38:33'),
  ('perm_users_create', 'users.create', 'Create Users', 'users', 'create', 'Add new users', '2026-01-18 06:38:33'),
  ('perm_users_read', 'users.read', 'View Users', 'users', 'read', 'View user information', '2026-01-18 06:38:33'),
  ('perm_users_update', 'users.update', 'Update Users', 'users', 'update', 'Modify user details', '2026-01-18 06:38:33'),
  ('perm_users_delete', 'users.delete', 'Delete Users', 'users', 'delete', 'Deactivate users', '2026-01-18 06:38:33'),
  ('perm_users_manage_roles', 'users.manage_roles', 'Manage User Roles', 'users', 'manage_roles', 'Assign/revoke user roles', '2026-01-18 06:38:33'),
  ('perm_settings_view', 'settings.view', 'View Settings', 'settings', 'read', 'View system settings', '2026-01-18 06:38:33'),
  ('perm_settings_update', 'settings.update', 'Update Settings', 'settings', 'update', 'Modify system settings', '2026-01-18 06:38:33'),
  ('perm_visits_create', 'visits.create', 'Create Visits', 'visits', 'create', 'Log field visits', '2026-01-18 06:38:33'),
  ('perm_visits_read', 'visits.read', 'View Visits', 'visits', 'read', 'View visit records', '2026-01-18 06:38:33'),
  ('perm_visits_update', 'visits.update', 'Update Visits', 'visits', 'update', 'Modify visit details', '2026-01-18 06:38:33'),
  ('perm_visits_approve', 'visits.approve', 'Approve Visits', 'visits', 'approve', 'Approve visit reports', '2026-01-18 06:38:33')
ON CONFLICT DO NOTHING;



-- Data for: pipeline_stages (14 rows)
INSERT INTO pipeline_stages (id, pipeline_id, stage_name, stage_order, stage_type, probability, expected_duration_days, color_code, is_active, created_at) VALUES
  ('8fcc713a29a3981d6a1e1efb0f23e806', '26e9c496435a8626997fba5b16e301c6', 'Lead', 1, 'open', 10, NULL, '#9CA3AF', 1, '2026-01-18 06:49:36'),
  ('4b7f2dff61002e8090d59530390b2991', '26e9c496435a8626997fba5b16e301c6', 'Qualified', 2, 'open', 25, NULL, '#3B82F6', 1, '2026-01-18 06:49:36'),
  ('dd31b647293970351d090f4f4dbf791e', '26e9c496435a8626997fba5b16e301c6', 'Meeting Scheduled', 3, 'open', 40, NULL, '#8B5CF6', 1, '2026-01-18 06:49:36'),
  ('8fa66cc20e959c62d9f78f0b6f2b72c0', '26e9c496435a8626997fba5b16e301c6', 'Proposal Sent', 4, 'open', 60, NULL, '#F59E0B', 1, '2026-01-18 06:49:36'),
  ('ae59e624bf1069c02782421b5dba74ea', '26e9c496435a8626997fba5b16e301c6', 'Negotiation', 5, 'open', 80, NULL, '#EF4444', 1, '2026-01-18 06:49:36'),
  ('32e3fbf83ef16c1da1a9068f892400bc', '26e9c496435a8626997fba5b16e301c6', 'Won', 6, 'won', 100, NULL, '#10B981', 1, '2026-01-18 06:49:36'),
  ('4f8c701bfb9573b1a39362f8094cbdc2', '26e9c496435a8626997fba5b16e301c6', 'Lost', 7, 'lost', 0, NULL, '#6B7280', 1, '2026-01-18 06:49:36'),
  ('2c61f16972278f34320691c719c25cc5', '095424f316cd663ba49897f00faff05d', 'Lead', 1, 'open', 10, NULL, '#9CA3AF', 1, '2026-01-18 06:49:48'),
  ('a0e55f6cc7ea1b13b0c5b3548fc5e35d', '095424f316cd663ba49897f00faff05d', 'Qualified', 2, 'open', 25, NULL, '#3B82F6', 1, '2026-01-18 06:49:48'),
  ('e775dcf504dcb3ee3ee4e484943b006a', '095424f316cd663ba49897f00faff05d', 'Meeting Scheduled', 3, 'open', 40, NULL, '#8B5CF6', 1, '2026-01-18 06:49:48'),
  ('0f582b5945bd1d73ff9f949bfefffee7', '095424f316cd663ba49897f00faff05d', 'Proposal Sent', 4, 'open', 60, NULL, '#F59E0B', 1, '2026-01-18 06:49:48'),
  ('18ceb648f7280c7a1b7a06fdc185a688', '095424f316cd663ba49897f00faff05d', 'Negotiation', 5, 'open', 80, NULL, '#EF4444', 1, '2026-01-18 06:49:48'),
  ('e3fdb1b03527af73abf5701c0796acb8', '095424f316cd663ba49897f00faff05d', 'Won', 6, 'won', 100, NULL, '#10B981', 1, '2026-01-18 06:49:48'),
  ('5cad04811fcc3f831d155170993b7584', '095424f316cd663ba49897f00faff05d', 'Lost', 7, 'lost', 0, NULL, '#6B7280', 1, '2026-01-18 06:49:48')
ON CONFLICT DO NOTHING;



-- Data for: pipelines (2 rows)
INSERT INTO pipelines (id, tenant_id, pipeline_name, description, is_default, is_active, created_by, created_at, updated_at) VALUES
  ('26e9c496435a8626997fba5b16e301c6', '101f04af63cbefc2bf8f0a98b9ae1205', 'B2B Sales Pipeline', 'Standard B2B sales process for enterprise deals', 1, 1, NULL, '2026-01-18 06:49:36', '2026-01-18 06:49:36'),
  ('095424f316cd663ba49897f00faff05d', '101f04af63cbefc2bf8f0a98b9ae1205', 'B2B Sales Pipeline', 'Standard B2B sales process for enterprise deals', 1, 1, NULL, '2026-01-18 06:49:48', '2026-01-18 06:49:48')
ON CONFLICT DO NOTHING;



-- Data for: price_lists (1 rows)
INSERT INTO price_lists (id, tenant_id, name, description, currency, effective_from, effective_to, is_default, is_active, created_at, updated_at) VALUES
  ('c970d8690b1740183e94772c52e442f5', '101f04af63cbefc2bf8f0a98b9ae1205', 'Standard Price List 2026', 'Default pricing for all products', 'INR', NULL, NULL, 1, 1, '2026-01-18 06:27:48', '2026-01-18 06:27:48')
ON CONFLICT DO NOTHING;



-- Data for: pricing_tiers (4 rows)
INSERT INTO pricing_tiers (id, tenant_id, tier_code, tier_name, description, discount_percentage, is_active, created_at, updated_at) VALUES
  ('bde6fbd4ed86598c0836b3e2e2705fae', '101f04af63cbefc2bf8f0a98b9ae1205', 'RETAIL', 'Retail', 'Standard retail pricing', 0, 1, '2026-01-18 06:27:48', '2026-01-18 06:27:48'),
  ('38f48b5e10d38b77659e7e7c89601c3a', '101f04af63cbefc2bf8f0a98b9ae1205', 'WHOLESALE', 'Wholesale', 'Wholesale buyers (15% off)', 15, 1, '2026-01-18 06:27:48', '2026-01-18 06:27:48'),
  ('d11e054e90efe13dfa56886e8ff72074', '101f04af63cbefc2bf8f0a98b9ae1205', 'DISTRIBUTOR', 'Distributor', 'Authorized distributors (25% off)', 25, 1, '2026-01-18 06:27:48', '2026-01-18 06:27:48'),
  ('2fea37c4445d2e7ebb32fb6f00bbf3bd', '101f04af63cbefc2bf8f0a98b9ae1205', 'VIP', 'VIP Account', 'Premium VIP customers (30% off)', 30, 1, '2026-01-18 06:27:48', '2026-01-18 06:27:48')
ON CONFLICT DO NOTHING;



-- Data for: product_prices (2 rows)
INSERT INTO product_prices (id, price_list_id, product_id, base_price, cost_price, min_price, max_price, created_at, updated_at) VALUES
  ('8f104a19aa0c7c7bb1e81bf395688385', 'c970d8690b1740183e94772c52e442f5', '4d29bfea1cdb7460467139d56c5db196', 1167.25, 700.35, 770.39, NULL, '2026-01-18 06:27:48', '2026-01-18 06:27:48'),
  ('7b4c587ca67c4069e8fb4a7360e5f9ea', 'c970d8690b1740183e94772c52e442f5', 'a1349b553da26bdfd926fa1f990b8feb', 4687.13, 2812.28, 3093.5, NULL, '2026-01-18 06:27:48', '2026-01-18 06:27:48')
ON CONFLICT DO NOTHING;



-- Data for: products (2 rows)
INSERT INTO products (id, tenant_id, name, description, category_id, category, brand, sku, model_number, price, stock_quantity, image_url, packaging_unit, units_per_carton, carton_price, is_active, zoho_item_id, created_at, updated_at, description_generated_by_ai) VALUES
  ('4d29bfea1cdb7460467139d56c5db196', '101f04af63cbefc2bf8f0a98b9ae1205', 'Sample Product 1', 'This is a test product', NULL, NULL, NULL, NULL, NULL, 100, 50, NULL, NULL, 1, NULL, 1, NULL, '2026-01-10 10:17:20', '2026-01-10 10:17:20', 0),
  ('a1349b553da26bdfd926fa1f990b8feb', '101f04af63cbefc2bf8f0a98b9ae1205', 'Sample Product 2', 'Another test product', NULL, NULL, NULL, NULL, NULL, 200, 30, NULL, NULL, 1, NULL, 1, NULL, '2026-01-10 10:17:20', '2026-01-10 10:17:20', 0)
ON CONFLICT DO NOTHING;



-- Data for: promotions (2 rows)
INSERT INTO promotions (id, tenant_id, code, name, description, discount_type, discount_value, min_order_value, max_discount_amount, applicable_products, applicable_categories, applicable_tiers, start_date, end_date, usage_limit, usage_count, is_active, created_at, updated_at) VALUES
  ('d0a3feb7bfa86a6617eac0194cf31251', '101f04af63cbefc2bf8f0a98b9ae1205', 'NEWCUST2026', 'New Customer Welcome', 'First time buyer discount', 'percentage', 10, 1000, 500, NULL, NULL, NULL, '2026-01-18T06:27:48.966Z', '2026-01-30T18:30:00.000Z', NULL, 0, 1, '2026-01-18 06:27:48', '2026-01-18 06:27:48'),
  ('1ba8de8a22e627ee3516fdbec1e182e5', '101f04af63cbefc2bf8f0a98b9ae1205', 'YEAR2026', '2026 New Year Sale', 'Celebrate 2026 with great savings', 'percentage', 20, 2000, 2000, NULL, NULL, NULL, '2026-01-18T06:27:48.966Z', '2026-01-30T18:30:00.000Z', NULL, 0, 1, '2026-01-18 06:27:49', '2026-01-18 06:27:49')
ON CONFLICT DO NOTHING;



-- Data for: role_permissions (100 rows)
INSERT INTO role_permissions (id, role_id, permission_id, created_at) VALUES
  ('13071960483abc33070b5f8b75b6e6e4', '62fb396cd040e6d44347d20983ccce94', 'perm_products_create', '2026-01-18 06:39:02'),
  ('8100256ec8df90839b6d0aa392d68f87', '62fb396cd040e6d44347d20983ccce94', 'perm_products_read', '2026-01-18 06:39:02'),
  ('0c35e1e8dbd0bd06c21f3969c52ee6ba', '62fb396cd040e6d44347d20983ccce94', 'perm_products_update', '2026-01-18 06:39:02'),
  ('18973f6c88283423c32d321dba0123ae', '62fb396cd040e6d44347d20983ccce94', 'perm_products_delete', '2026-01-18 06:39:02'),
  ('17e6f42476eeeef4a4be312bd4893fa7', '62fb396cd040e6d44347d20983ccce94', 'perm_products_export', '2026-01-18 06:39:02'),
  ('9224c63ae83c4ed0e69c63edba2a778c', '62fb396cd040e6d44347d20983ccce94', 'perm_orders_create', '2026-01-18 06:39:02'),
  ('64e215af5816a3dc17cbbd41e12ec5cc', '62fb396cd040e6d44347d20983ccce94', 'perm_orders_read', '2026-01-18 06:39:02'),
  ('ebe9f3e6caefc9bde48cb0c416935471', '62fb396cd040e6d44347d20983ccce94', 'perm_orders_update', '2026-01-18 06:39:02'),
  ('c489761e32eec4f68055873122b7f1a5', '62fb396cd040e6d44347d20983ccce94', 'perm_orders_delete', '2026-01-18 06:39:02'),
  ('d85fabda113b6a11c3a509962c749122', '62fb396cd040e6d44347d20983ccce94', 'perm_orders_approve', '2026-01-18 06:39:02'),
  ('cd592d15bb698164ca8190f2e291d83a', '62fb396cd040e6d44347d20983ccce94', 'perm_customers_create', '2026-01-18 06:39:02'),
  ('0ac4d7506526e0e7e91050cb5f275efb', '62fb396cd040e6d44347d20983ccce94', 'perm_customers_read', '2026-01-18 06:39:02'),
  ('393efa868c6e20280dee9b5491d19103', '62fb396cd040e6d44347d20983ccce94', 'perm_customers_update', '2026-01-18 06:39:02'),
  ('8e0b0735889b2482245add6b3fae5841', '62fb396cd040e6d44347d20983ccce94', 'perm_customers_delete', '2026-01-18 06:39:02'),
  ('54ac8f85989f4349ac2c0bc95a0bf039', '62fb396cd040e6d44347d20983ccce94', 'perm_customers_export', '2026-01-18 06:39:02'),
  ('e9bcc02b5096a2dc05706eab98458e83', '62fb396cd040e6d44347d20983ccce94', 'perm_pricing_view', '2026-01-18 06:39:02'),
  ('6d0e9116d743144cd894b865c042c771', '62fb396cd040e6d44347d20983ccce94', 'perm_pricing_manage', '2026-01-18 06:39:02'),
  ('27c83793d74aba5fdc7074c2e959874d', '62fb396cd040e6d44347d20983ccce94', 'perm_pricing_override', '2026-01-18 06:39:02'),
  ('dc6498480e44a6345a5cb7e7717407bc', '62fb396cd040e6d44347d20983ccce94', 'perm_pricing_approve', '2026-01-18 06:39:02'),
  ('1358ad586d7bf44ff79ed5e4caf57b40', '62fb396cd040e6d44347d20983ccce94', 'perm_reports_view', '2026-01-18 06:39:02'),
  ('e88c166b55a4bb4dc9b1676adc58cc8d', '62fb396cd040e6d44347d20983ccce94', 'perm_reports_export', '2026-01-18 06:39:02'),
  ('8362467d31e33948969c8b9b87767258', '62fb396cd040e6d44347d20983ccce94', 'perm_analytics_advanced', '2026-01-18 06:39:02'),
  ('735f1e219b79b112fe97ff175d58c7d6', '62fb396cd040e6d44347d20983ccce94', 'perm_users_create', '2026-01-18 06:39:02'),
  ('d2c22644a792ae8e424926f4acc05e1e', '62fb396cd040e6d44347d20983ccce94', 'perm_users_read', '2026-01-18 06:39:02'),
  ('42d58d809d6f2a59bf6534dfe3c95c8d', '62fb396cd040e6d44347d20983ccce94', 'perm_users_update', '2026-01-18 06:39:02'),
  ('a85dc73b2fcc3000c975810a1824bd85', '62fb396cd040e6d44347d20983ccce94', 'perm_users_delete', '2026-01-18 06:39:02'),
  ('9e6eff4a1ae6b2aa5cd3f08a505d2ee2', '62fb396cd040e6d44347d20983ccce94', 'perm_users_manage_roles', '2026-01-18 06:39:02'),
  ('d685273ed40c6b8fa4ded81e4dd2d4cb', '62fb396cd040e6d44347d20983ccce94', 'perm_settings_view', '2026-01-18 06:39:02'),
  ('58ccf6b079f93fc03d2d6d5771f54b5c', '62fb396cd040e6d44347d20983ccce94', 'perm_settings_update', '2026-01-18 06:39:02'),
  ('165f61589ab6a54231cdb0f8b430e8aa', '62fb396cd040e6d44347d20983ccce94', 'perm_visits_create', '2026-01-18 06:39:02'),
  ('f8675c6dbf9f2a14d10f702ba752c624', '62fb396cd040e6d44347d20983ccce94', 'perm_visits_read', '2026-01-18 06:39:02'),
  ('36c1675c6c72320d32837367afb3c4b2', '62fb396cd040e6d44347d20983ccce94', 'perm_visits_update', '2026-01-18 06:39:02'),
  ('83d2e6636e74f1cd21c0c9a0da32b9f3', '62fb396cd040e6d44347d20983ccce94', 'perm_visits_approve', '2026-01-18 06:39:02'),
  ('e2952ae6283c9c1135daa5a404ad0d00', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_products_create', '2026-01-18 06:39:02'),
  ('9bd8b63e8f725d4704ca1193f1e209f9', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_products_read', '2026-01-18 06:39:02'),
  ('c048c87fdd69f84e97560eb7455c4dbe', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_products_update', '2026-01-18 06:39:02'),
  ('e1c9f822ccab316ed2e2976f846607dc', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_products_delete', '2026-01-18 06:39:02'),
  ('1ecda703debf861f930e7465d244ce78', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_products_export', '2026-01-18 06:39:02'),
  ('2a564135454e4a3c54286839d612927f', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_orders_create', '2026-01-18 06:39:02'),
  ('432f70f7fb53914b5221a324b2c8477b', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_orders_read', '2026-01-18 06:39:02'),
  ('1002b14ff0a8e253bd417707a935799c', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_orders_update', '2026-01-18 06:39:02'),
  ('72e3335cac73c678da5aa13a9437f17d', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_orders_delete', '2026-01-18 06:39:02'),
  ('32c3580ca78b41602ad48cca7114caf9', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_orders_approve', '2026-01-18 06:39:02'),
  ('67a660f6a39b1e400066400ffff77281', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_customers_create', '2026-01-18 06:39:02'),
  ('8e5192e160934d8213126f194fcb9c59', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_customers_read', '2026-01-18 06:39:02'),
  ('1099d5a785011640bb6f312c8bc3a0bc', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_customers_update', '2026-01-18 06:39:02'),
  ('c4abcc5b7b2bc2a66249d26ef1357984', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_customers_delete', '2026-01-18 06:39:02'),
  ('185294f76364a80f1949cc00bfdfe9da', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_customers_export', '2026-01-18 06:39:02'),
  ('97e7517279199c0000477aa2e779c20c', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_pricing_view', '2026-01-18 06:39:02'),
  ('c254a0cd73cd625ac3a76088fbdcb519', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_pricing_manage', '2026-01-18 06:39:02'),
  ('6814daef1e4a800f6294cac2ebecf9d7', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_reports_view', '2026-01-18 06:39:02'),
  ('d14915fc63a1b56acb7c94dcf6cfdc03', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_reports_export', '2026-01-18 06:39:02'),
  ('de3f61bca35344653a2443c57aa9db4c', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_analytics_advanced', '2026-01-18 06:39:02'),
  ('5eb75b7bb2ae16dd75f316d6acb7e078', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_users_read', '2026-01-18 06:39:02'),
  ('9ca3de2312fd152c0990a15724ac51e3', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_users_update', '2026-01-18 06:39:02'),
  ('b6f1b734ef1c78c552e40f669f42a1fd', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_visits_create', '2026-01-18 06:39:02'),
  ('f366cac1b1428ea4444a543c95260896', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_visits_read', '2026-01-18 06:39:02'),
  ('cd7976489032dcf7f4093b521e83d180', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_visits_update', '2026-01-18 06:39:02'),
  ('0e4c738256f1e2a787a69e3430d16319', '4b7ab1e54d1d97068de39a8d5d481b51', 'perm_visits_approve', '2026-01-18 06:39:02'),
  ('7e4ae19ed74b4f010f4c5eaf1428c25e', '86bb567d997a2b72aba0a832811a0355', 'perm_products_read', '2026-01-18 06:39:02'),
  ('4577ec5c7e5717f4f4f26703868b3e9e', '86bb567d997a2b72aba0a832811a0355', 'perm_orders_create', '2026-01-18 06:39:02'),
  ('1f7f442ca3974ddc8b0d31354b5efcc6', '86bb567d997a2b72aba0a832811a0355', 'perm_orders_read', '2026-01-18 06:39:02'),
  ('1eaeeb9e1ce8bd226c8de6ef6de53f7a', '86bb567d997a2b72aba0a832811a0355', 'perm_orders_update', '2026-01-18 06:39:02'),
  ('f9b48d1a6c1da6ee01d35bf60229add8', '86bb567d997a2b72aba0a832811a0355', 'perm_orders_delete', '2026-01-18 06:39:02'),
  ('a3434dc478121b4960547f5e1bbb91ea', '86bb567d997a2b72aba0a832811a0355', 'perm_orders_approve', '2026-01-18 06:39:02'),
  ('65b2c661cd410d019e614db3d225d1a0', '86bb567d997a2b72aba0a832811a0355', 'perm_customers_create', '2026-01-18 06:39:02'),
  ('11b10c0ddd3962009c53382e72d7b3a8', '86bb567d997a2b72aba0a832811a0355', 'perm_customers_read', '2026-01-18 06:39:02'),
  ('3754b5114c2fb12b380f117cb9b9a505', '86bb567d997a2b72aba0a832811a0355', 'perm_customers_update', '2026-01-18 06:39:02'),
  ('8b345c44f583b76de76ba8360f01bbd1', '86bb567d997a2b72aba0a832811a0355', 'perm_customers_delete', '2026-01-18 06:39:02'),
  ('e9fe4733d42f4caab7b3eccdd67a859c', '86bb567d997a2b72aba0a832811a0355', 'perm_customers_export', '2026-01-18 06:39:02'),
  ('3acb020feeb6412f979480e4107db26f', '86bb567d997a2b72aba0a832811a0355', 'perm_pricing_view', '2026-01-18 06:39:02'),
  ('f52a08d8e5e9a48d67109ed8c8646fde', '86bb567d997a2b72aba0a832811a0355', 'perm_pricing_override', '2026-01-18 06:39:02'),
  ('edc12a9546eafbb82ec966fed7078dc3', '86bb567d997a2b72aba0a832811a0355', 'perm_reports_view', '2026-01-18 06:39:02'),
  ('592035640964799751ce9f1021da31ed', '86bb567d997a2b72aba0a832811a0355', 'perm_reports_export', '2026-01-18 06:39:02'),
  ('a5c399e49f3be90a9ac1245de0f44337', '86bb567d997a2b72aba0a832811a0355', 'perm_analytics_advanced', '2026-01-18 06:39:02'),
  ('cd08f04924eb9dbf6df6876e7bf6ecf9', '86bb567d997a2b72aba0a832811a0355', 'perm_visits_approve', '2026-01-18 06:39:02'),
  ('b033bd4e6c710e93d1154d1e27baca83', '16ecbeff80b982f4c38bd71440c62f59', 'perm_products_read', '2026-01-18 06:39:02'),
  ('98bc84c718fb63c12914be9858abc8bc', '16ecbeff80b982f4c38bd71440c62f59', 'perm_orders_create', '2026-01-18 06:39:02'),
  ('b4276f0d9de35a04f13428cd85484337', '16ecbeff80b982f4c38bd71440c62f59', 'perm_orders_read', '2026-01-18 06:39:02'),
  ('4b30fe7d08f4482526a373750afda57a', '16ecbeff80b982f4c38bd71440c62f59', 'perm_orders_update', '2026-01-18 06:39:02'),
  ('1e0c9da20354777c019db835b119c86f', '16ecbeff80b982f4c38bd71440c62f59', 'perm_customers_create', '2026-01-18 06:39:02'),
  ('680de5b3f4f329ea15fa8031c05551e7', '16ecbeff80b982f4c38bd71440c62f59', 'perm_customers_read', '2026-01-18 06:39:02'),
  ('1dd3e597b3e950d86049aaa30e7344cc', '16ecbeff80b982f4c38bd71440c62f59', 'perm_customers_update', '2026-01-18 06:39:02'),
  ('c7474f65f5cd69d197cb2170528fa5ee', '16ecbeff80b982f4c38bd71440c62f59', 'perm_pricing_view', '2026-01-18 06:39:02'),
  ('9499a92c21a31f7c223bfb34d8617b90', '16ecbeff80b982f4c38bd71440c62f59', 'perm_visits_create', '2026-01-18 06:39:02'),
  ('11f95fc2c40341704e2539f54bda5a3a', '16ecbeff80b982f4c38bd71440c62f59', 'perm_visits_read', '2026-01-18 06:39:02'),
  ('3356561284da417126b2d9c3846293b2', '16ecbeff80b982f4c38bd71440c62f59', 'perm_visits_update', '2026-01-18 06:39:02'),
  ('3da30c40ce30a3784548d95fdc6ed1e1', '43b255f1d9b109a312a6b5bc93f98bff', 'perm_products_read', '2026-01-18 06:39:02'),
  ('b347a9c3dd799c00947b9a0364eeea11', '43b255f1d9b109a312a6b5bc93f98bff', 'perm_orders_read', '2026-01-18 06:39:02'),
  ('f2678989d0ce49071e4536a27153569d', '43b255f1d9b109a312a6b5bc93f98bff', 'perm_orders_update', '2026-01-18 06:39:02'),
  ('5f951c9838a194217df2babc772a8f6d', '43b255f1d9b109a312a6b5bc93f98bff', 'perm_customers_read', '2026-01-18 06:39:02'),
  ('f4403674611d7e1c6e02e73c5e79ffe1', '43b255f1d9b109a312a6b5bc93f98bff', 'perm_customers_update', '2026-01-18 06:39:02'),
  ('98bace0919d3fcbde8435229656423a6', '43b255f1d9b109a312a6b5bc93f98bff', 'perm_pricing_view', '2026-01-18 06:39:02'),
  ('c7223884011cdae3709a827804e63ce2', '43b255f1d9b109a312a6b5bc93f98bff', 'perm_reports_view', '2026-01-18 06:39:02'),
  ('d6939452dc46fef17dbdee1ab4174f4c', '0b388b982a39c42ca14f2f85559c6d02', 'perm_orders_read', '2026-01-18 06:39:02'),
  ('4dc81726ffafbcfa7d8d6843b565b8d8', '0b388b982a39c42ca14f2f85559c6d02', 'perm_customers_read', '2026-01-18 06:39:02'),
  ('2d748943451163ae95ddb390ecf03a8c', '0b388b982a39c42ca14f2f85559c6d02', 'perm_pricing_view', '2026-01-18 06:39:02'),
  ('bd42ea7430d60bbe03e6c95020ec8f66', '0b388b982a39c42ca14f2f85559c6d02', 'perm_reports_view', '2026-01-18 06:39:02'),
  ('333b0ba2a239b46595883469c4116c6a', '0b388b982a39c42ca14f2f85559c6d02', 'perm_reports_export', '2026-01-18 06:39:02'),
  ('d1cf75ed991d513c20c74cedc7d3e854', '0b388b982a39c42ca14f2f85559c6d02', 'perm_analytics_advanced', '2026-01-18 06:39:02')
ON CONFLICT DO NOTHING;


