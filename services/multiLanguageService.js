// services/multiLanguageService.js
const { openai } = require('./config');

const FAST_MODEL = process.env.AI_MODEL_FAST || 'gpt-4o-mini';

/**
 * Detect language from user message
 */
const detectLanguage = async (text) => {
  try {
    if (!openai) return 'en';
    const response = await openai.chat.completions.create({
      model: FAST_MODEL,
      messages: [{
        role: "system", 
        content: `Detect the language of the message. Respond with ONLY one of these codes:
- 'en' for pure English
- 'hi' for pure Hindi
- 'hinglish' for any mix of Hindi and English words
- 'ar' for Arabic
- 'ur' for Urdu
- 'es' for Spanish
- 'fr' for French
- Other ISO 639-1 language codes as needed

Look at the script/characters used to identify the language accurately.`
      }, {
        role: "user",
        content: text
      }],
      temperature: 0,
      max_tokens: 10
    });
    
    return response.choices[0].message.content.trim().toLowerCase();
  } catch (error) {
    console.error('Language detection error:', error);
    return 'en'; // Default to English
  }
};

/**
 * Translate message to user's preferred language
 */
const translateMessage = async (text, targetLanguage) => {
  if (targetLanguage === 'en') return text;
  
  try {
    if (!openai) return text;
    const languageMap = {
      'hi': 'Hindi (हिंदी)',
      'hinglish': 'Hinglish - a natural mix of Hindi and English commonly used in India',
      'ar': 'Arabic (العربية)',
      'ur': 'Urdu (اردو)',
      'es': 'Spanish (Español)',
      'fr': 'French (Français)',
      'de': 'German (Deutsch)',
      'pt': 'Portuguese (Português)',
      'ru': 'Russian (Русский)',
      'zh': 'Chinese (中文)',
      'ja': 'Japanese (日本語)',
      'ko': 'Korean (한국어)'
    };
    
    const targetLangName = languageMap[targetLanguage] || targetLanguage.toUpperCase();
    
    const response = await openai.chat.completions.create({
      model: FAST_MODEL,
      messages: [{
        role: "system",
        content: `You are a professional translator. Translate the following business/sales message to ${targetLangName}. 
- Maintain professional and friendly tone
- Keep formatting (line breaks, emojis if present)
- For Hinglish: use natural mixing of Hindi and English as commonly spoken in India
- For Arabic: use Modern Standard Arabic that is widely understood
- Preserve any product codes, prices, or technical terms
- Make it sound natural and conversational`
      }, {
        role: "user", 
        content: text
      }],
      temperature: 0.3
    });
    
    return response.choices[0].message.content.trim();
  } catch (error) {
    console.error('Translation error:', error);
    return text; // Return original if translation fails
  }
};

module.exports = {
  detectLanguage,
  translateMessage
};
