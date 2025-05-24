FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    ccache \
    git \
    zip \
    unzip \
    openjdk-17-jdk \
    wget \
    libncurses5 \
    libstdc++6 \
    libffi-dev \
    libssl-dev \
    libsqlite3-dev \
    zlib1g-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libpng-dev \
    libgl1-mesa-glx \
    && apt-get clean

# Install Android command line tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip -O /tmp/tools.zip \
    && mkdir -p /opt/android/cmdline-tools \
    && unzip /tmp/tools.zip -d /opt/android/cmdline-tools \
    && rm /tmp/tools.zip

# Set environment variables
ENV ANDROID_HOME=/opt/android
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/cmdline-tools/bin:$ANDROID_HOME/platform-tools

# Accept SDK licenses (may fail initially without packages)
RUN mkdir -p ~/.android && echo 'count=0' > ~/.android/repositories.cfg

# Install buildozer
RUN pip install --no-cache-dir --upgrade pip setuptools cython
RUN pip install --no-cache-dir buildozer

# Patch Buildozer to skip root check (optional)
RUN python3 -c "import buildozer; path = buildozer.__file__; data = open(path).read(); data = data.replace('cont = input', 'cont = \"y\" # patched'); open(path, 'w').write(data)"

WORKDIR /home/user/app

CMD ["buildozer", "--help"]
