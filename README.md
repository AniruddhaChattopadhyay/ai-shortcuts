# ✨ Mac AI Shortcuts

A collection of native macOS Quick Actions that let you transform text in **any application** using OpenAI.

Highlight text anywhere (Notes, Slack, Browser, Mail), Right-Click, and watch it transform instantly.

## 🎬 Demo

<video src="ai-shortcut-demo.mov" controls></video>

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
| **🌐 AI Translate**      | English → Spanish or Other → English            |
| **💡 AI Explain Simply** | Explain in simple terms anyone can understand   |
| **💬 AI Reply**          | Draft a response to a message                   |

---

## Why this tool?

|                          |                                                                          |
| ------------------------ | ------------------------------------------------------------------------ |
| 🚀 **Zero Dependencies** | No Python, Node.js, or Homebrew required. Works on a fresh Mac.          |
| ⚡️ **Native**           | Uses macOS built-in "Quick Actions" and JXA (JavaScript for Automation). |
| 🔒 **Private**           | Your API key is stored locally on your machine.                          |
| 🛠 **Customizable**       | Easily change the AI prompts or model.                                   |

---

## 📦 Installation

Open your Terminal app and paste the following command:

```bash
curl -sL https://raw.githubusercontent.com/AniruddhaChattopadhyay/ai-shortcuts/main/install.sh | bash
```

> **Note:** You will be asked to:
>
> 1. Enter your OpenAI API Key
> 2. Choose your preferred AI model (gpt-5.2, gpt-5-mini, gpt-5-nano, or gpt-4o)

---

## 🔑 How to get an OpenAI API Key

If you don't have a key yet, follow these simple steps:

1. Go to [platform.openai.com](https://platform.openai.com) and log in or sign up.
2. Click on **Dashboard → API Keys** in the left menu.
3. Click **+ Create new secret key**.
4. Name it "Mac AI Shortcuts" and click **Create secret key**.
5. Copy the key (it starts with `sk-...`).
6. Paste it into the terminal when the installer asks for it.

> **Note:** You need a small amount of credit (e.g., $5) in your OpenAI account for the API to work.

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

### Change Model

To switch to a different model after installation, edit `~/.mac-ai-companion/config.json`:

```bash
open ~/.mac-ai-companion/config.json
```

Change the `"model"` value to one of:

- `"gpt-5.2"` - Latest, most capable
- `"gpt-5-mini"` - Fast and cost-efficient
- `"gpt-5-nano"` - Fastest and most affordable
- `"gpt-4o"` - Previous generation, reliable
- `"gpt-4o-mini"` - Fast and affordable

### Change Prompts

All scripts are stored at `~/.mac-ai-companion/`.

1. Open Terminal.
2. Type: `open ~/.mac-ai-companion/`
3. Edit any `.js` file with a text editor.
4. Find the `messages` section and change the `content`:

```javascript
// Example: Make the rewrite sarcastic
{"role": "system", "content": "You are a sarcastic comedian. Rewrite this text to be funny."}
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

| Component                           | Purpose                                                         |
| ----------------------------------- | --------------------------------------------------------------- |
| **Automator**                       | Creates the Quick Action menu items.                            |
| **JXA (JavaScript for Automation)** | Uses standard macOS built-in JavaScript engine to handle logic. |
| **cURL**                            | Handles the HTTP request to OpenAI securely.                    |

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
