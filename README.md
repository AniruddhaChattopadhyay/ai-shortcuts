# ✨ Mac AI Shortcuts

A collection of native macOS Quick Actions that let you transform text in **any application** using **OpenAI**, **Anthropic Claude**, or **Google Gemini**.

Highlight text anywhere (Notes, Slack, Browser, Mail), Right-Click, and watch it transform instantly.

## 🎬 Demo

![AI Shortcuts Demo](ai-shortcut-demo.gif)

---

## 🎯 Available Shortcuts

| Shortcut                 | What it does                                    |
| ------------------------ | ----------------------------------------------- |
| **✨ AI Rewrite**        | Rewrite text to be clear, professional, concise |
| **📝 AI Summarize**      | Condense long text into key bullet points       |
| **✓ AI Fix Grammar**     | Fix spelling, grammar, and punctuation          |
| **😊 AI Make Casual**    | Rewrite in a friendly, conversational tone      |
| **✂️ AI Make Shorter**   | Condense while keeping the meaning              |
| **📖 AI Expand**         | Elaborate and add more detail                   |
| **🌐 AI Translate**      | Translate any language to English               |
| **💡 AI Explain Simply** | Explain in simple terms anyone can understand   |
| **💬 AI Reply**          | Draft a response to a message                   |

---

## 🤖 Supported AI Providers

| Provider      | Models Available                                                         |
| ------------- | ------------------------------------------------------------------------ |
| **OpenAI**    | GPT-5.2, GPT-5-mini, GPT-5-nano (default), GPT-4o                        |
| **Anthropic** | Claude Sonnet 4.5 (default), Claude Sonnet 4, Claude Haiku 4.5           |
| **Google**    | Gemini 2.5 Flash (default), Gemini 2.5 Flash Lite, Gemini 2.0 Flash/Lite |

---

## Why this tool?

|                          |                                                                          |
| ------------------------ | ------------------------------------------------------------------------ |
| 🚀 **Zero Dependencies** | No Python, Node.js, or Homebrew required. Works on a fresh Mac.          |
| ⚡️ **Native**           | Uses macOS built-in "Quick Actions" and JXA (JavaScript for Automation). |
| 🔒 **Private**           | Your API key is stored locally on your machine.                          |
| 🛠 **Customizable**       | Easily change the AI prompts, model, or provider.                        |
| 🤖 **Multi-Provider**    | Works with OpenAI, Anthropic Claude, and Google Gemini.                  |

---

## 📦 Installation

Open your Terminal app and paste the following command:

```bash
curl -sL https://raw.githubusercontent.com/AniruddhaChattopadhyay/ai-shortcuts/main/install.sh | bash
```

> **During installation, you will be asked to:**
>
> 1. Choose your AI provider (OpenAI, Anthropic, or Google)
> 2. Enter your API key for that provider
> 3. Choose your preferred AI model

---

## 🔑 How to Get an API Key

### OpenAI

1. Go to [platform.openai.com](https://platform.openai.com) and log in or sign up.
2. Click **Dashboard → API Keys** in the left menu.
3. Click **+ Create new secret key**.
4. Name it "Mac AI Shortcuts" and click **Create secret key**.
5. Copy the key (starts with `sk-...`).

> You need a small amount of credit (e.g., $5) in your OpenAI account.

### Anthropic

1. Go to [console.anthropic.com](https://console.anthropic.com) and log in or sign up.
2. Go to **API Keys** in the dashboard.
3. Click **Create Key**.
4. Copy the key (starts with `sk-ant-...`).

> You need credits in your Anthropic account.

### Google Gemini

1. Go to [aistudio.google.com](https://aistudio.google.com) and log in.
2. Click **Get API Key** in the left menu.
3. Create a new API key.
4. Copy the key.

> Gemini offers a free tier with generous limits.

---

## ⚡️ Usage

1. Open any app (TextEdit, Notes, Chrome, Slack, etc.).
2. **Select/Highlight** some text.
3. **Right Click** the selection.
4. Go to **Services** (or look at the bottom of the menu).
5. Click any **AI shortcut** (e.g., AI Rewrite, AI Summarize).

The selected text will be replaced by the AI-transformed version.

### First Run Permissions

The first time you run this, macOS might ask for permission.

- Click **"Allow"** if asked to run the script.
- If nothing happens, go to **System Settings → Privacy & Security → Automation** and ensure the app you are using (e.g., Chrome) has permission to communicate with "System Events".

---

## ⚙️ Customization

### Change Provider or Model

Edit your config file:

```bash
open ~/.mac-ai-companion/config.json
```

Example config:

```json
{
  "provider": "openai",
  "api_key": "sk-...",
  "model": "gpt-5-nano"
}
```

#### Available Models

**OpenAI:**

- `gpt-5.2` - Latest, most capable
- `gpt-5-mini` - Fast and cost-efficient
- `gpt-5-nano` - Fastest and most affordable
- `gpt-4o` - Previous generation, reliable

**Anthropic:**

- `claude-sonnet-4-5-20250929` - Sonnet 4.5, most capable (recommended)
- `claude-sonnet-4-20250514` - Sonnet 4, balanced
- `claude-haiku-4-5-20251001` - Haiku 4.5, fastest

**Google Gemini:**

- `gemini-2.5-flash` - Latest, fast (recommended)
- `gemini-2.5-flash-lite` - Fast and cost-efficient
- `gemini-2.0-flash` - Reliable, proven
- `gemini-2.0-flash-lite` - Budget-friendly

### Change Prompts

All scripts are stored at `~/.mac-ai-companion/`.

1. Open Terminal.
2. Type: `open ~/.mac-ai-companion/`
3. Edit any `.js` file with a text editor.
4. Find the `systemPrompt` line and change it:

```javascript
// Example: Make the rewrite sarcastic
var systemPrompt =
  "You are a sarcastic comedian. Rewrite this text to be funny.";
```

### Available Scripts

| File                | Shortcut          |
| ------------------- | ----------------- |
| `rewrite.js`        | AI Rewrite        |
| `summarize.js`      | AI Summarize      |
| `fix-grammar.js`    | AI Fix Grammar    |
| `make-casual.js`    | AI Make Casual    |
| `make-shorter.js`   | AI Make Shorter   |
| `expand.js`         | AI Expand         |
| `translate.js`      | AI Translate      |
| `explain-simply.js` | AI Explain Simply |
| `reply.js`          | AI Reply          |

---

## 🗑 Uninstalling

To remove all shortcuts completely, run this in your terminal:

```bash
curl -sL https://raw.githubusercontent.com/AniruddhaChattopadhyay/ai-shortcuts/main/uninstall.sh | bash
```

---

## 🔧 Under the Hood

For developers wondering how this works without Python:

| Component                           | Purpose                                                              |
| ----------------------------------- | -------------------------------------------------------------------- |
| **Automator**                       | Creates the Quick Action menu items.                                 |
| **JXA (JavaScript for Automation)** | Uses standard macOS built-in JavaScript engine to handle logic.      |
| **cURL**                            | Handles HTTP requests to OpenAI, Anthropic, or Google APIs securely. |

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
