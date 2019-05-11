class Libgimp20 < Formula
  desc "Headers and other files for compiling plugins for GIMP"
  homepage "https://www.gimp.org/"
  url "https://gitlab.gnome.org/GNOME/gimp.git", tag: "GIMP_2_10_10"
  version "2.10.10"
  sha256 ""

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "intltool" => :build
  depends_on "libffi" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  %w[
    babl
    cairo
    gegl
    gettext
    gexiv2
    glib-networking
    gtk-mac-integration
    lcms2
    libmypaint
    librsvg
    pango
    poppler
    pygtk
    ryan-robeson/gimp/mypaint-brushes
  ].each do |d|
    depends_on d
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    args = %w[
      --disable-debug
      --disable-dependency-tracking
      --disable-gtk-doc
      --disable-maintainer-mode
      --disable-silent-rules
      --without-libxpm
    ]

    # autogen.sh calls configure
    system "./autogen.sh", "--prefix=#{prefix}",
                           *args
    #system "./configure", "--prefix=#{prefix}",
    #                      *args

    system "make"
    #interactive_shell
 
    # Install files based on Debian's packages (libgimp2.0 and libgimp2.0-dev)
    # https://packages.debian.org/sid/amd64/libgimp2.0/filelist
    # https://packages.debian.org/sid/amd64/libgimp2.0-dev/filelist
    include_gimp = include + "gimp-2.0"
    lib_pkgconfig = lib + "pkgconfig"

    include_gimp.mkpath
    Dir["libgimp*/"].each do |d|
      (include_gimp + d).install Dir["#{d}/*.h"]
    end

    lib.install Dir["libgimp*/.libs/*.dylib"]

    lib_pkgconfig.install %w[ gimp-2.0.pc gimpthumb-2.0.pc gimpui-2.0.pc]

    (share + "aclocal").install "m4macros/gimp-2.0.m4"

    bin.install "tools/gimptool-2.0"

    Dir["po-libgimp/*.gmo"].each do |f|
      locale = File.basename(f).gsub(/(.+)\.gmo/, '\1')
      locale_dir = share/"locale"/locale/"LC_MESSAGES"
      mkdir_p locale_dir
      locale_dir.install f => locale_dir/"gimp20-libgimp.mo"
    end
    
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test libgimp2.0`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
