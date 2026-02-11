# Use the official n8n image
FROM n8nio/n8n:latest

# Switch to root to install software
USER root

# Install FFmpeg using apt-get (Debian style)
RUN apt-get update && apt-get install -y ffmpeg

# Switch back to node user for security
USER node
