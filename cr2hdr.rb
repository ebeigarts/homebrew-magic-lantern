require_relative "magic_lantern_formula"

class Cr2hdr < MagicLanternFormula
  depends_on "dcraw"
  depends_on "exiftool"

  def install
    resource_rst2html
    cd "modules/dual_iso" do
      if ENV.compiler == :clang
        inreplace "Makefile.cr2hdr", " -mno-ms-bitfields", ""
      end
      system "make cr2hdr"
      bin.install "cr2hdr"
    end
  end

  def caveats
    <<-EOS.undent
      Before you can use cr2hdr you must install Adobe DNG Converter

      $ brew install caskroom/cask/brew-cask
      $ brew cask install adobe-dng-converter
    EOS
  end

  test do
    system "#{bin}/cr2hdr"
  end
end
