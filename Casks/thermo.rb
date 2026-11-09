cask "thermo" do
  version "1.5.44"
  sha256 "e595562c1648f5d105f17301d2e14a468fa2cbc7dc2864ce89a0753a2bc4083b"

  url "https://app.leeguoo.com/thermo/Thermo-#{version}.dmg"
  name "Thermo"
  desc "Temperatures, fans, disk cleanup and AI agent diagnostics"
  homepage "https://app.leeguoo.com/thermo"

  livecheck do
    url "https://app.leeguoo.com/thermo/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :ventura

  app "Thermo.app"
  binary "#{appdir}/Thermo.app/Contents/Helpers/thermo"

  # Stopping the helper returns the fans to automatic control and restores the sleep setting.
  uninstall launchctl: "dev.thermo.helper",
            quit:      "dev.thermo.app",
            delete:    [
              "/Library/LaunchDaemons/dev.thermo.helper.plist",
              "/Library/PrivilegedHelperTools/dev.thermo.helper",
            ]

  zap trash: [
    "~/Library/Application Support/Thermo",
    "~/Library/Caches/dev.thermo",
    "~/Library/Logs/Thermo",
    "~/Library/Preferences/dev.thermo.app.plist",
  ]
end
