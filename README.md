# OOUIFemiwikiTheme

Femiwiki Theme is a theme for [OOUI]

## Build

```sh
git clone --recurse-submodules https://github.com/femiwiki/OOUIFemiwikiTheme
# If you already cloned:
#   git submodule update --recursive --remote
npm install
./build.sh
```

## Bump oojs-ui

```sh
git checkout main
git pull
git checkout -b REL1_43
git submodule update --init --recursive --remote
cd oojs-ui
git checkout v0.51.2 --force
cd ..
git add oojs-ui
git commit -m 'MediaWiki 1.43 supports for OOUI v0.51.2' -m 'https://github.com/wikimedia/mediawiki-vendor/blob/REL1_43/composer.json'

asdf install nodejs $(cat oojs-ui/.nvmrc)
asdf local nodejs $(cat oojs-ui/.nvmrc)
npm install
./build.sh
git add dist
git commit -m Rebuild
```

[ooui]: https://www.mediawiki.org/wiki/OOUI
