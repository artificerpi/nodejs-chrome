FROM node:latest

LABEL maintainer="artificerpi@outlook.com"

ARG CHROME_VERSION="google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    apt-utils ${CHROME_VERSION:-google-chrome-stable} xvfb libgconf2-4 libxss1 \
  && apt-get -qqy remove --purge apt-utils \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/

# Tricky way to wrapper google-chrome script: add line before exec chrome binary
RUN sed -i '/^exec -a.*/i [[ -f /tmp/.X11-unix/X1 ]] || Xvfb :1 -screen 0 "1280x1024x16" -ac &> /dev/null &' /opt/google/chrome/google-chrome

USER node
ENV DISPLAY=:1
