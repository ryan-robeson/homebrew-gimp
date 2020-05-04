class PixelArtScalers < Formula
  desc "Gimp plugin for rescaling images with Pixel Art Scaler algorithms such as hqx, xbr and scalex"
  homepage "https://github.com/bbbbbr/gimp-plugin-pixel-art-scalers"
  head "https://github.com/bbbbbr/gimp-plugin-pixel-art-scalers.git"
  url "https://github.com/bbbbbr/gimp-plugin-pixel-art-scalers.git", tag: "v1.1"

  bottle do
    root_url "https://github.com/ryan-robeson/homebrew-gimp/releases/download/v1.3"
    cellar :any
    sha256 "ba1438c943e0945b18f4cb0046bbe0c544b42215fef4e710f4af03d9e709a9f3" => :catalina
    sha256 "ba1438c943e0945b18f4cb0046bbe0c544b42215fef4e710f4af03d9e709a9f3" => :mojave
    sha256 "ba1438c943e0945b18f4cb0046bbe0c544b42215fef4e710f4af03d9e709a9f3" => :high_sierra
    sha256 "ba1438c943e0945b18f4cb0046bbe0c544b42215fef4e710f4af03d9e709a9f3" => :sierra
  end

  depends_on "ryan-robeson/gimp/libgimp2.0"

  def install
    system "make"

    plugin_dir = share/"gimp-plugins"/"pixel-art-scalers"
    plugin_dir.install "plugin-pixel-art-scalers"
  end

  # Not auto-installing plugin per:
  # https://github.com/Homebrew/homebrew-core/issues/4010#issuecomment-240784629
  def caveats
    plugin_dir = HOMEBREW_PREFIX/"share"/"gimp-plugins"/"pixel-art-scalers"
    cli_install_msg = nil

    s = <<~EOS
      Make sure '#{plugin_dir}' is in GIMP's list of plug-in directories:
        Preferences -> Folders -> Plug-ins

      Restart GIMP to activate #{specified_name}.
      #{cli_install_msg}
      If anything goes wrong with the bottle try installing from source.
        `brew uninstall #{specified_name}; brew install --build-from-source #{specified_name}`

      Please report any issues to:
        https://github.com/ryan-robeson/homebrew-gimp/issues
    EOS
    s
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # Run the test with `brew test pixel-art-scalers`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
  end
end
