class Resynthesizer < Formula
  desc "Suite of gimp plugins for texture synthesis"
  homepage "https://github.com/bootchk/resynthesizer"
  head "https://github.com/bootchk/resynthesizer.git"
  url "https://github.com/bootchk/resynthesizer.git", tag: "v2.0.3"

  bottle do
    root_url "https://github.com/ryan-robeson/homebrew-gimp/releases/download/v1.2"
    cellar :any
    rebuild 1
    sha256 "e2f0213d1f0c2d7aa2934912ad8cc00e495f9c2f43a810fce70658e5fdc2ed97" => :catalina
    sha256 "e2f0213d1f0c2d7aa2934912ad8cc00e495f9c2f43a810fce70658e5fdc2ed97" => :mojave
    sha256 "e2f0213d1f0c2d7aa2934912ad8cc00e495f9c2f43a810fce70658e5fdc2ed97" => :high_sierra
    sha256 "e2f0213d1f0c2d7aa2934912ad8cc00e495f9c2f43a810fce70658e5fdc2ed97" => :sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "ryan-robeson/gimp/libgimp2.0"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    #interactive_shell
    system "make"

    plugin_dir = share/"gimp-plugins"/"resynthesizer"
    plugin_dir.install "src/resynthesizer/resynthesizer"
    plugin_dir.install "src/resynthesizer-gui/resynthesizer_gui"
    plugin_dir.install Dir["PluginScripts/*.py"]
    chmod "a+x", Dir[plugin_dir/"*.py"]
  end

  # Not auto-installing plugin per:
  # https://github.com/Homebrew/homebrew-core/issues/4010#issuecomment-240784629
  def caveats
    plugin_dir = HOMEBREW_PREFIX/"share"/"gimp-plugins"/"resynthesizer"
    cli_install_msg = nil

    ### Future Reference
    # I wanted to provide users with a command to automatically add
    # 'plugin_dir' to their plug-in-path either user only or system wide.
    # However, what I came up with has too many assumptions and is not very
    # pretty. I'm keeping it around for now in case I decide to revisit it. It
    # may be abandoned at some point.
    #
    # Assumptions:
    #   * User config
    #     * file exists
    #     * already has plug-in-path listed
    #       * Should pull setting from System config if missing
    #     * only one instance of uncommented plug-in-path
    #   * System config
    #     * User config does not override plug-in-path
    #       * should alert if overridden
    #     * Could have multiple instances of plug-in-path
    #       (Commented or not)
    #     * Last plug-in-path found is the one to append to
    #       (Prioritizing uncommented)
    #
    # # Attempt to locate GIMP install
    # # Search for user-private location first
    # search_private = Dir["#{ENV['HOME']}/Library/Application Support/GIMP/*"]
    # search_system = Dir["/Applications/GIMP*"]
    # private_dir = nil
    # system_dir = nil

    # if search_private.count > 0
    #   if search_private.count == 1
    #     private_dir = search_private[0] + "/plug-ins"
    #   else
    #     # Find the newest GIMP version by first extracting the version number
    #     # NOTE: This is probably overkill and/or unnecessary and there's probably
    #     # a better way to do this.
    #     private_dir = search_private.map do |p|
    #       {
    #         version: File.basename(p).split('.'),
    #         path: p
    #       }
    #     end.reduce do |result, e|
    #       # Compare the version numbers by looping through each one
    #       # and only changing result when
    #       # e[0..n] == result[0..n] && e[n+1] > result[n+1]
    #       result = e if e[:version].each.with_index do |el, i|
    #         a = el.to_i
    #         b = result[:version][i].to_i
    #         next if a == b
    #         break a > b
    #       end

    #       result
    #     end[:path]
    #   end
    # end

    # if search_system.count > 0
    #   if search_system.count == 1
    #     system_dir = search_system[0] + "/Contents/Resources/etc/gimp/2.0"
    #     # TODO: Support multiple system wide installations like private configs above
    #   end
    # end

    # cli_install_msg = "Or do the same thing via the command line:\n\n"

    # if private_dir
    #   cli_user_install = %Q(ruby -pi.plugin-bak -e 'if /^\(plug-in-path/ && ! %r(#{plugin_dir}) then path = $_.dup; $_.prepend("#"); path.insert(path.index(/"\)/), "#{plugin_dir}"); $_ += path; end' '#{private_dir}/gimprc')

    #   cli_install_msg += <<~EOS.gsub(/^/, "  ")
    #     User Only
    #     =========
    #     #{cli_user_install}

    #   EOS
    # end

    # if system_dir
    #   cli_system_install = %Q(cp '#{system_dir}/gimprc' '#{system_dir}/gimprc.plugin-bak' && )
    #   cli_system_install += %q(ruby -e 'f = File.read(ARGV[0]); pip = %q|\\(plug-in-path.+|; plugin = f.scan(/^#{pip}/); return unless plugin.grep(/#{ARGV[1]}/).empty?; if !plugin.empty? then plugin = plugin.last.dup; f.gsub!(/^(#{pip})/, "# \1"); else plugin = f.scan(/^#\s*#{pip}/).last.dup.gsub(/#\s*/, ""); end; plugin.sub!(/(?="\\))/, ":#{ARGV[1]}"); f += plugin; File.write(ARGV[0], f)' )
    #   cli_system_install += %Q('#{system_dir}/gimprc' '#{plugin_dir}')

    #   cli_install_msg += <<~EOS.gsub(/^/, "  ")
    #     System Wide
    #     ===========
    #     #{cli_system_install}
    #   EOS
    # end
    #
    # END Future Reference

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
    # Run the test with `brew test resynthesizer`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
  end
end
