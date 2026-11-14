FROM debian:bookworm-slim

# Установка необходимых утилит
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENV TERM=xterm

# Прямая ссылка на программу Linux AMD64
ARG DOWNLOAD_URL="https://github.com/0x8fv/Twitch-Channel-Points-Miner/releases/download/1.5/TwitchChannelPointsMiner-linux-amd64"

# Скачивание программы
RUN curl -fL "$DOWNLOAD_URL" -o /app/program && \
    chmod +x /app/program

# Создание config.json
RUN cat > /app/config.json <<'EOF'
{
  "auto_update": true,
  "bet": {
    "deduct_stake_on_place": true,
    "delay": null,
    "delay_mode": null,
    "filter_condition": {
      "by": null,
      "value": null,
      "where": null
    },
    "max_points": null,
    "minimum_points": null,
    "percentage": null,
    "percentage_gap": null,
    "stealth_mode": null,
    "strategy": null
  },
  "betting(make_predictions)": true,
  "chat_presence": "ONLINE",
  "claim_drops": true,
  "claim_drops_startup": true,
  "claim_moments": true,
  "community_goals": false,
  "debug": false,
  "debug_deep": false,
  "disable_at_in_nickname": false,
  "disable_ssl_cert_verification": false,
  "discord": {
    "events": [],
    "webhook_api": ""
  },
  "emojis": false,
  "follow_raid": true,
  "game_exclude": [],
  "game_priority": [],
  "password": "pass123",
  "privacy": {
    "anonymize_logs": false
  },
  "save_logs": false,
  "show_claimed_bonus_msg": true,
  "show_drops_progress": false,
  "show_game": true,
  "show_seconds": false,
  "show_username_in_console": true,
  "smart_logging": true,
  "streamer_overrides": {},
  "streamers": ["BadgeTracker"],
  "streamers_exclude": [],
  "timezone": null,
  "username": "ogyre4uk2008",
  "watch_priority": [
    "ORDER",
    "DROPS",
    "STREAK"
  ],
  "watch_queue_logging": false,
  "watch_streak_warm_start_cache": true
}
EOF

# Запуск программы
CMD ["/app/program"]
