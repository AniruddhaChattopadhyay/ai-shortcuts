# ✨ Mac AI Rewrite

A native macOS companion that lets you rewrite, fix, or summarize text in **any application** using OpenAI.

Highlight text anywhere (Notes, Slack, Browser, Mail), Right-Click, and watch it transform instantly.

---

## Why this tool?

|                          |                                                                          |
| ------------------------ | ------------------------------------------------------------------------ |
| 🚀 **Zero Dependencies** | No Python, Node.js, or Homebrew required. Works on a fresh Mac.          |
| ⚡️ **Native**           | Uses macOS built-in "Quick Actions" and JXA (JavaScript for Automation). |
| 🔒 **Private**           | Your API key is stored locally on your machine.                          |
| 🛠 **Customizable**       | Easily change the AI prompt or model.                                    |

---

## 📦 Installation

Open your Terminal app and paste the following command:

```bash
curl -sL https://raw.githubusercontent.com/AniruddhaChattopadhyay/ai-shortcuts/main/install.sh | bash
```

> **Note:** You will be asked to paste your OpenAI API Key during installation.

---

## 🔑 How to get an OpenAI API Key

If you don't have a key yet, follow these simple steps:

1. Go to [platform.openai.com](https://platform.openai.com) and log in or sign up.
2. Click on **Dashboard → API Keys** in the left menu.
3. Click **+ Create new secret key**.
4. Name it "Mac Rewrite" and click **Create secret key**.
5. Copy the key (it starts with `sk-...`).
6. Paste it into the terminal when the installer asks for it.

> **Note:** You need a small amount of credit (e.g., $5) in your OpenAI account for the API to work.

---

## ⚡️ Usage

1. Open any app (TextEdit, Notes, Chrome, Slack, etc.).
2. **Select/Highlight** some text.
3. **Right Click** the selection.
4. Go to **Services** (or just look at the bottom of the menu).
5. Click **✨ AI Rewrite**.

The selected text will briefly freeze while the AI thinks, and then it will be replaced by the improved version.

### First Run Permissions

The first time you run this, macOS might ask for permission.

- Click **"Allow"** if asked to run the script.
- If nothing happens, go to **System Settings → Privacy & Security → Automation** and ensure the app you are using (e.g., Chrome) has permission to communicate with "System Events".

---

## ⚙️ Customization

Want to change the prompt (e.g., "Make it funny" instead of "Professional") or change the model to GPT-4?

The logic file is stored at `~/.mac-ai-companion/rewrite.js`. You can edit it with any text editor.

1. Open Terminal.
2. Type: `open ~/.mac-ai-companion/rewrite.js`
3. Find the `messages` section and change the `content` instructions:

```javascript
// Example change:
{"role": "system", "content": "You are a sarcastic comedian. Rewrite this text to be funny."}
```

---

## 🗑 Uninstalling

To remove the tool completely, run this in your terminal:

```bash
curl -sL https://raw.githubusercontent.com/AniruddhaChattopadhyay/ai-shortcuts/main/uninstall.sh | bash
```

---

## 🔧 Under the Hood

For developers wondering how this works without Python:

| Component                           | Purpose                                                         |
| ----------------------------------- | --------------------------------------------------------------- |
| **Automator**                       | Creates the Service menu item.                                  |
| **JXA (JavaScript for Automation)** | Uses standard macOS built-in JavaScript engine to handle logic. |
| **cURL**                            | Handles the HTTP request to OpenAI securely.                    |

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
