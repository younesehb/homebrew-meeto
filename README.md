# homebrew-meeto

Tap Homebrew du client macOS de [meeto](https://github.com/younesehb/meeto) (enregistrement et transcription de
réunions, entièrement en local).

```sh
brew tap younesehb/meeto
brew install --cask meeto
```

macOS 15 ou plus, Apple Silicon. Le binaire (`MeetoClient.app`, signature ad hoc) est publié dans les releases de ce dépôt, le code de meeto restant
privé ; le cask est mis à jour par `scripts/release.sh` de meeto à chaque release.
