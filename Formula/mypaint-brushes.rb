class MypaintBrushes < Formula
  desc "Brushes used by MyPaint and other software using libmypaint"
  homepage "https://github.com/mypaint/mypaint-brushes/tree/v1.3.x"
  #head "https://github.com/mypaint/mypaint-brushes.git"
  url "https://github.com/mypaint/mypaint-brushes.git", branch: "v1.3.x"
  version "v1.3.x"

  bottle do
    root_url "https://github.com/ryan-robeson/homebrew-gimp/releases/download/v1.0"
    cellar :any_skip_relocation
    sha256 "370bda5f529377983e0a6a17a58ff29f437f03885e2dc92f4e49e262fdbcfd65" => :catalina
    sha256 "370bda5f529377983e0a6a17a58ff29f437f03885e2dc92f4e49e262fdbcfd65" => :mojave
    sha256 "370bda5f529377983e0a6a17a58ff29f437f03885e2dc92f4e49e262fdbcfd65" => :high_sierra
    sha256 "370bda5f529377983e0a6a17a58ff29f437f03885e2dc92f4e49e262fdbcfd65" => :sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "./autogen.sh"
    system "./configure", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    #interactive_shell
    system "make", "install" # if this fails, try separate make/make install steps
  end

  def caveats
    s = <<~EOS
      If anything goes wrong with the bottle try installing from source.
        `brew uninstall mypaint-brushes; brew install --build-from-source mypaint-brushes`

      Please report any issues to:
        https://github.com/ryan-robeson/homebrew-gimp/issues
    EOS
    s
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # Run the test with `brew test mypaint-brushes`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    (Pathname(share) + "mypaint-data").exist?
  end
end
