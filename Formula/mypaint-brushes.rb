class MypaintBrushes < Formula
  desc "Brushes used by MyPaint and other software using libmypaint"
  homepage "https://github.com/mypaint/mypaint-brushes/tree/v1.3.x"
  #head "https://github.com/mypaint/mypaint-brushes.git"
  url "https://github.com/mypaint/mypaint-brushes.git", branch: "v1.3.x"
  version "v1.3.x"

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
