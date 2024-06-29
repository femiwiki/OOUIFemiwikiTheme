#!/bin/bash
set -euxo pipefail
IFS=$'\n\t'

WD=$(dirname "$0")

if [ ! -f "$WD/oojs-ui/yarn.lock" ]; then
  echo 'Installing dependencies'
  yarn --cwd "$WD/oojs-ui"
fi

echo 'Adding Femiwiki theme'
yarn grunt --gruntfile "$WD/oojs-ui/Gruntfile.js" add-theme --name=Femiwiki --template=WikimediaUI

echo 'Building Femiwiki theme'
cat "$WD/src/femiwiki-base.less" >>"$WD/oojs-ui/node_modules/@wikimedia/codex-design-tokens/theme-wikimedia-ui-legacy.less"
find "$WD/"oojs-ui/src/themes/femiwiki/*.json -exec sed -i 's/"#36c"/"#aca7e2"/g' {} \;

echo 'Building OOUI themes'
yarn grunt --gruntfile "$WD/oojs-ui/Gruntfile.js" build

echo 'Moveing Femiwiki Theme to dist'
mkdir -p "$WD/dist/php/" "$WD/dist/resources/" "$WD/dist/femiwiki/images/images"
cp "$WD/oojs-ui/php/themes/FemiwikiTheme.php" "$WD/dist/"
cp "$WD/oojs-ui/dist/oojs-ui-femiwiki.js" "$WD/dist/resources/"
cp "$WD"/oojs-ui/dist/oojs-ui-femiwiki-*.css "$WD/dist/resources/"
cp "$WD"/oojs-ui/dist/oojs-ui-*-femiwiki.css "$WD/dist/resources/"
cp "$WD"/oojs-ui/dist/themes/femiwiki/icons-*.json "$WD/dist/resources/"
cp -r "$WD/oojs-ui/dist/themes/femiwiki/images" "$WD/dist/resources/images/"
cp -r "$WD/oojs-ui/dist/themes/femiwiki/images/icons" "$WD/dist/femiwiki/images/icons"
cp -r "$WD"/dist/femiwiki/images/icons/icons/* "$WD/dist/resources/images/icons/"

echo "Done"
