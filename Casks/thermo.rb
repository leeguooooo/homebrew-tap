cask "thermo" do
  version "1.5.53"
  sha256 "0e87f1d38e874ed1e60b2f1cce6ac174c1dfd913d69b2079a6c6fed6119442e5"

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
