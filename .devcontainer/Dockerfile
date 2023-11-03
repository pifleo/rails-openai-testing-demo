FROM mcr.microsoft.com/devcontainers/ruby:1-3.2-bullseye

# Ensure gems are installed on a persistent volume and available as bins
VOLUME /bundle
RUN su vscode -c "bundle config set --global path '/bundle'"
ENV PATH="/bundle/ruby/$RUBY_VERSION/bin:${PATH}"

# Ensure gems are installed on a persistent volume and available as bins
# by linking the "ruby-dev-container-bundle-cache" volume to the BUNDLE_APP_CONFIG value ("/usr/local/bundle") on "docker run" commands
# See: https://github.com/docker-library/ruby/blob/master/3.2/alpine3.18/Dockerfile#L159'

# Install Rails
RUN su vscode -c "gem install rails webdrivers --no-document"
RUN su vscode -c "/usr/local/rvm/bin/rvm fix-permissions"

# Add some aliases to the Docker image
# COPY --chown=vscode:vscode .devcontainer/.bash_aliases /home/vscode/.bash_aliases
# Do it via symlink from a file stored in the shared volume as Docker build doesn't follow symlinks
RUN su vscode -c "ln -s /bundle/home-vscode-dotfiles/.bash_aliases /home/vscode/.bash_aliases"

# Default value to allow debug server to serve content over GitHub Codespace's port forwarding service
# The value is a comma-separated list of allowed domains
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev,.preview.app.github.dev,.app.github.dev"

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# Add Rails Active Storage requirements
# https://guides.rubyonrails.org/active_storage_overview.html#requirements
RUN apt update && apt -y install libvips imagemagick ghostscript ffmpeg mupdf mupdf-tools # fonts-noto fonts-freefont-otf

# [Optional] Uncomment this line to install additional gems.
# RUN su vscode -c "gem install <your-gem-names-here>"
RUN su vscode -c "gem install solargraph rubocop rubocop-rails rubocop-rspec rubocop-performance htmlbeautifier --no-document"

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install --lts" 2>&1
