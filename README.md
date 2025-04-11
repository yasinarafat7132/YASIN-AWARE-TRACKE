# YASIN-AWARE-TRACKER

A QR-based tracker tool built for **awareness** and **education**.  
When someone scans the QR and opens the link, their IP, location, and ISP info is collected and sent directly to your **Telegram Bot**.

---

## Features

- QR Code based redirect page
- Collects:
  - IP Address
  - Location (City, Region, Country)
  - ISP Info
- Sends data to Telegram bot (auto)
- Terminal shows status
- Built with: PHP + Ngrok + Telegram API + JavaScript
- Easy to upload & run from GitHub or Termux

---

## Installation (Termux)

```bash
pkg install git -y
git clone https://github.com/YOUR_USERNAME/YASIN-AWARE-TRACKER
cd YASIN-AWARE-TRACKER
chmod +x tracker.sh
bash tracker.sh
