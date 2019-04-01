#!/bin/sh

if test ! $(which rbenv)
then
  echo "Installing rbenv for you."
  brew install rbenv > /tmp/rbenv-install.log
fi

if test ! $(which ruby-build)
then
  echo "Installing ruby-build for you."
  brew install ruby-build > /tmp/ruby-build-install.log
fi

# ruby version to install
RUBY_VERSION=2.6.2

rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION

# Install utility gems
bundle install
