#!/usr/bin/env python3
"""
Test script for AI Shortcuts - Tests all providers and models using actual JXA scripts.
Reads API keys from .env file and runs the scripts via osascript.

Usage:
    1. Create a .env file with your API keys (see .env.example)
    2. Run: python3 test_providers.py
"""

import os
import json
import subprocess
from pathlib import Path

# Load .env file manually (no dependencies needed)
env_path = Path(__file__).parent / ".env"
if env_path.exists():
    with open(env_path) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#") and "=" in line:
                key, value = line.split("=", 1)
                os.environ[key.strip()] = value.strip().strip('"').strip("'")


# Colors for terminal output
class Colors:
    GREEN = "\033[92m"
    RED = "\033[91m"
    YELLOW = "\033[93m"
    BLUE = "\033[94m"
    BOLD = "\033[1m"
    END = "\033[0m"


def check(success):
    return f"{Colors.GREEN}✓{Colors.END}" if success else f"{Colors.RED}✗{Colors.END}"


# Config paths
HOME = os.path.expanduser("~")
CONFIG_PATH = os.path.join(HOME, ".mac-ai-companion", "config.json")
SCRIPTS_DIR = os.path.join(HOME, ".mac-ai-companion")

# Provider configurations
PROVIDERS = {
    "openai": {
        "models": ["gpt-5.2", "gpt-5-mini", "gpt-5-nano", "gpt-4o"],
        "env_key": "OPENAI_API_KEY",
    },
    "anthropic": {
        "models": [
            "claude-sonnet-4-5-20250929",
            "claude-sonnet-4-20250514",
            "claude-haiku-4-5-20251001",
        ],
        "env_key": "ANTHROPIC_API_KEY",
    },
    "gemini": {
        "models": [
            "gemini-2.5-flash",
            "gemini-2.5-flash-lite",
            "gemini-2.0-flash",
            "gemini-2.0-flash-lite",
        ],
        "env_key": "GEMINI_API_KEY",
    },
}

TEST_INPUT = "hey can u plz help me with this thing its really confusing lol"


def update_config(provider: str, api_key: str, model: str) -> None:
    """Update the config.json file with provider, api_key, and model."""
    config = {"provider": provider, "api_key": api_key, "model": model}
    os.makedirs(os.path.dirname(CONFIG_PATH), exist_ok=True)
    with open(CONFIG_PATH, "w") as f:
        json.dump(config, f)


def run_script(script_name: str, input_text: str) -> tuple[bool, str]:
    """Run a JXA script via osascript and return (success, output)."""
    script_path = os.path.join(SCRIPTS_DIR, script_name)

    if not os.path.exists(script_path):
        return False, f"Script not found: {script_path}"

    try:
        result = subprocess.run(
            ["/usr/bin/osascript", "-l", "JavaScript", script_path, input_text],
            capture_output=True,
            text=True,
            timeout=60,
        )

        output = result.stdout.strip()

        # Check if we got a meaningful response (not empty, not error, not same as input)
        if output and not output.startswith("Error:") and output != input_text:
            return True, output
        elif output == input_text:
            return False, "Output same as input (API may have failed silently)"
        elif not output:
            return False, "Empty response"
        else:
            return False, output

    except subprocess.TimeoutExpired:
        return False, "Timeout (60s)"
    except Exception as e:
        return False, str(e)


def main():
    print(f"\n{Colors.BOLD}🧪 AI Shortcuts - Provider & Model Test{Colors.END}")
    print(f"   Testing actual JXA scripts via osascript")
    print("=" * 55)

    # Check if scripts exist
    if not os.path.exists(SCRIPTS_DIR):
        print(f"\n{Colors.RED}Error: Scripts directory not found at {SCRIPTS_DIR}")
        print(f"Please run the installer first.{Colors.END}")
        return 1

    # Backup original config
    original_config = None
    if os.path.exists(CONFIG_PATH):
        with open(CONFIG_PATH) as f:
            original_config = f.read()

    results = {"passed": 0, "failed": 0, "skipped": 0}

    try:
        for provider_name, config in PROVIDERS.items():
            print(f"\n{Colors.BLUE}{Colors.BOLD}📦 {provider_name.upper()}{Colors.END}")
            print("-" * 45)

            api_key = os.environ.get(config["env_key"])

            if not api_key:
                print(
                    f"  {Colors.YELLOW}⚠ Skipped (no {config['env_key']} in .env){Colors.END}"
                )
                results["skipped"] += len(config["models"])
                continue

            for model in config["models"]:
                # Update config for this test
                update_config(provider_name, api_key, model)

                # Run the rewrite.js script as the test
                success, response = run_script("rewrite.js", TEST_INPUT)
                status = check(success)

                if success:
                    results["passed"] += 1
                    # Truncate response for display
                    display_response = (
                        response[:50] + "..." if len(response) > 50 else response
                    )
                    print(f"  {status} {model}")
                    print(f"      └─ {display_response}")
                else:
                    results["failed"] += 1
                    print(f"  {status} {model}")
                    print(f"      └─ {Colors.RED}{response[:60]}{Colors.END}")

    finally:
        # Restore original config
        if original_config:
            with open(CONFIG_PATH, "w") as f:
                f.write(original_config)
            print(f"\n{Colors.YELLOW}ℹ Restored original config.json{Colors.END}")

    # Summary
    print(f"\n{'=' * 55}")
    print(f"{Colors.BOLD}📊 Summary{Colors.END}")
    print(f"  {Colors.GREEN}✓ Passed:{Colors.END}  {results['passed']}")
    print(f"  {Colors.RED}✗ Failed:{Colors.END}  {results['failed']}")
    print(f"  {Colors.YELLOW}⚠ Skipped:{Colors.END} {results['skipped']}")

    total = results["passed"] + results["failed"]
    if total > 0:
        success_rate = (results["passed"] / total) * 100
        print(f"\n  Success Rate: {success_rate:.0f}%")

    if results["failed"] == 0 and results["passed"] > 0:
        print(f"\n{Colors.GREEN}{Colors.BOLD}🎉 All tests passed!{Colors.END}")
    elif results["failed"] > 0:
        print(f"\n{Colors.RED}{Colors.BOLD}❌ Some tests failed.{Colors.END}")

    return 0 if results["failed"] == 0 else 1


if __name__ == "__main__":
    exit(main())
