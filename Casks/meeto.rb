cask "meeto" do
  version "0.4.0"
  sha256 "a57498252acecd037cabf03f6e27bc654bc07ab649f2b149ed6bf2e43a2b0f17"

  # Le dépôt meeto est privé : le binaire est publié dans les releases de ce tap.
  url "https://github.com/younesehb/homebrew-meeto/releases/download/v#{version}/MeetoClient-macos-arm64.zip"
  name "Meeto"
  desc "Records meetings from the Mac and sends them to a self-hosted meeto server"
  homepage "https://github.com/younesehb/homebrew-meeto"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "MeetoClient-v#{version}/MeetoClient.app"
  binary "#{appdir}/MeetoClient.app/Contents/MacOS/meeto-client"

  # Signature ad hoc, pas de notarisation : sans ça, Gatekeeper refuse d'ouvrir l'app.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/MeetoClient.app"]
  end

  uninstall launchctl: "com.meeto.client",
            quit:      "com.meeto.client"

  zap trash: [
    "~/Library/Application Support/meeto",
    "~/Library/LaunchAgents/com.meeto.client.plist",
    "~/Library/Logs/meeto-client.log",
    "~/Library/Preferences/com.meeto.client.plist",
  ]

  caveats <<~EOS
    Ouvrez MeetoClient (icône dans la barre de menus) › Réglages : adresse du serveur meeto et jeton
    (`meeto token` sur le serveur). Au premier enregistrement, autorisez « Enregistrement de l'audio système »
    et le micro ; à redonner après chaque mise à jour (signature ad hoc).
  EOS
end
