#!/bin/bash

# Define the installation directory
FLUTTER_INSTALL_DIR="$HOME/development"

# URL for the Flutter SDK tar.xz file
FLUTTER_SDK_URL="https://github.com/flutter/flutter/archive/refs/tags/2.5.2.tar.gz"

# Install Flutter
if ! command -v flutter &> /dev/null; then
  echo "Flutter not found. Installing..."

  # Create the installation directory
  mkdir -p "$FLUTTER_INSTALL_DIR"

  # Download and extract Flutter
  cd "$FLUTTER_INSTALL_DIR"
  curl -o flutter.tar.xz -L "$FLUTTER_SDK_URL"
  tar xf "flutter.tar.xz"

  # Add Flutter to the PATH for this session
  export PATH="$PATH:`pwd`/flutter/bin"

  echo "Flutter installation completed."
else
  echo "Flutter is already installed."
fi

# Check if Flutter is in the PATH for all future sessions
if ! grep -q "flutter/bin" "$HOME/.bashrc"; then
echo 'export PATH="$PATH:'"`pwd`/flutter/bin"'"' >> "$HOME/.bashrc"

  echo "PATH updated for all future sessions."
fi

# Print installation instructions
echo "Please review the Flutter installation instructions at:"
echo "https://flutter.dev/docs/get-started/install/linux"
if ! command -v flutter &> /dev/null; then
  echo "Flutter not found. Installing..."
else
  sudo apt install snapd
  sudo systemctl enable snapd
  sudo systemctl start snapd
  sudo snap install flutter --classic
fi
  echo "Flutter installation completed."