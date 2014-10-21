# Magic Lantern needs hg to build something, so use hg clone instead of archive.
class MagicLanternDownloadStrategy < MercurialDownloadStrategy
  def stage
    dst = Dir.getwd
    @clone.cd do
      if @ref_type and @ref
        ohai "Checking out #{@ref_type} #{@ref}"
        safe_system hgpath, 'clone', '-y', '-r', @ref, '.', dst
      else
        safe_system hgpath, 'clone', '-y', '.', dst
      end
    end
  end
end
