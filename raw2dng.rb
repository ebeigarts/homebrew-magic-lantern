require_relative "magic_lantern_formula"

class Raw2dng < MagicLanternFormula
  def install
    resource_rst2html
    cd "modules/raw_rec" do
      system "make raw2dng"
      bin.install "raw2dng"
    end
  end

  test do
    system "#{bin}/raw2dng"
  end
end
