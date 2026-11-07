cask "thermo" do
  version "1.5.25"
  sha256 "77c9a1564d5099590476e4d49550efab3528f2f429c68c3d876e72c1c0c645fd"

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
