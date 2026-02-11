# --- Stage 1: The Builder (Downloads FFmpeg) ---
FROM alpine:latest as builder

# Install tools needed to download files
RUN apk add --no-cache wget tar xz

# Download the "Static" FFmpeg binary (works on any Linux)
# We use John Van Sickle's build which is the industry standard for this
RUN wget -q https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
    && tar -xf ffmpeg-release-amd64-static.tar.xz \
    && mv ffmpeg-*-amd64-static/ffmpeg /ffmpeg \
    && chmod 755 /ffmpeg

# --- Stage 2: The Actual n8n Image ---
FROM n8nio/n8n:latest

# Switch to root to allow file copying
USER root

# Copy the FFmpeg binary from the builder stage
COPY --from=builder /ffmpeg /usr/local/bin/ffmpeg

# Switch back to the safe user
USER node
