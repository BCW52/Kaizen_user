#!/bin/bash

# Define the installation directory
FLUTTER_INSTALL_DIR="$HOME"

# URL for the Flutter SDK tar.xz file
FLUTTER_SDK_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.5.2-stable.tar.xz"

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
  echo 'export PATH="$PATH:$HOME/flutter/bin"' >> "$HOME/.bashrc"

  echo "PATH updated for all future sessions."
fi

# Print installation instructions
echo "Please review the Flutter installation instructions at:"
echo "https://flutter.dev/docs/get-started/install/linux"


# Set Gradle version and distribution URL
GRADLE_VERSION="7.0.2"
GRADLE_URL="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"

# Set installation directory
INSTALL_DIR="/usr/local/gradle"

# Create the installation directory if it doesn't exist
sudo mkdir -p $INSTALL_DIR

# Download Gradle distribution
echo "Downloading Gradle ${GRADLE_VERSION}..."
sudo wget $GRADLE_URL

# Unzip the distribution and move it to the installation directory
echo "Installing Gradle..."
sudo unzip "gradle-${GRADLE_VERSION}-bin.zip" -d $INSTALL_DIR

# Set up environment variables
echo "Configuring environment variables..."
echo "export GRADLE_HOME=$INSTALL_DIR/gradle-${GRADLE_VERSION}" >> ~/.bashrc
echo "export PATH=\$GRADLE_HOME/bin:\$PATH" >> ~/.bashrc

# Apply the changes to the current shell
source ~/.bashrc

# Verify the installation
gradle -v

echo "Gradle installation complete."
