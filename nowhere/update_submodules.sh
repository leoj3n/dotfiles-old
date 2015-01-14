#!/bin/bash

DOTFILES="${HOME}/.homesick/repos/dotfiles"

echo
echo 'Updating Submodules...'
echo

cd "${DOTFILES}/nowhere" && git submodule foreach git pull

echo
echo 'Build YouTubeCenter...'
echo

cd "${DOTFILES}/submodules/chrome/YouTubeCenter" && ant copy-chrome

echo
echo 'Unzip Octotree...'
echo

cd "${DOTFILES}/submodules/chrome/octotree/dist" && rm -rf 'chrome' && unzip 'chrome.zip' -d 'chrome'

echo
echo 'Build Vimium...'
echo

cd "${DOTFILES}/submodules/chrome/vimium" && cake build

echo
echo 'Finished updating submodules.'
echo


