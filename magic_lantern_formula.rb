require "formula"
require_relative "magic_lantern_download_strategy"

class MagicLanternFormula < Formula
  def self.inherited(subclass)
    subclass.class_eval do
      homepage "http://www.magiclantern.fm/"
      head "https://bitbucket.org/hudson/magic-lantern",
        :using => MagicLanternDownloadStrategy,
        :branch => "unified"
      env :std

      resource "docutils" do
        url "https://pypi.python.org/packages/source/d/docutils/docutils-0.12.tar.gz"
        sha1 "002450621b33c5690060345b0aac25bc2426d675"
      end
    end
  end

  def resource_rst2html
    resource("docutils").stage do
      system "python", "setup.py", "install", "--prefix=#{buildpath}"
    end

    ENV.prepend_create_path "PYTHONPATH", buildpath/"lib/python2.7/site-packages"
    ENV.prepend_path "PATH", buildpath/"bin"
    ln_sf buildpath/"bin/rst2html.py", buildpath/"bin/rst2html"
  end
end
