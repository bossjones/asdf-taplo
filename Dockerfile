FROM ubuntu:22.04

# Prevent tzdata from asking for user input
ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies and Python build dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    unzip \
    tar \
    bash \
    wget \
    gpg \
    gawk \
    zsh \
    vim \
    sudo \
    bash-completion \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash asdf_user \
    && echo "asdf_user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER asdf_user
WORKDIR /home/asdf_user

# Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1 \
    && echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc \
    && echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc

# Source asdf in current shell
SHELL ["/bin/bash", "-c"]

# Copy the plugin to the container
COPY --chown=asdf_user:asdf_user . /home/asdf_user/.asdf/plugins/taplo

# Add asdf to PATH for the subsequent commands
ENV PATH="/home/asdf_user/.asdf/bin:/home/asdf_user/.asdf/shims:${PATH}"

# Install tools one at a time to better handle potential failures
RUN . "$HOME/.asdf/asdf.sh" \
    && asdf plugin add nodejs \
    && asdf install nodejs latest \
    && asdf global nodejs latest

RUN . "$HOME/.asdf/asdf.sh" \
    && asdf plugin add python \
    && asdf install python 3.12.1 \
    && asdf global python 3.12.1

RUN . "$HOME/.asdf/asdf.sh" \
    && asdf plugin add rust \
    && asdf install rust 1.82.0 \
    && asdf global rust 1.82.0

# Set up a nice prompt
RUN echo 'export PS1="\[\e[32m\]asdf-test\[\e[m\] \[\e[33m\]\w\[\e[m\] > "' >> ~/.bashrc

# Default command
CMD ["/bin/bash"]
