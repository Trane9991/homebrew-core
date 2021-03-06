class Mmv < Formula
  desc "Move, copy, append, and link multiple files"
  homepage "https://packages.debian.org/unstable/utils/mmv"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/m/mmv/mmv_1.01b.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/m/mmv/mmv_1.01b.orig.tar.gz"
  sha256 "0399c027ea1e51fd607266c1e33573866d4db89f64a74be8b4a1d2d1ff1fdeef"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "d754f546b6e586df4ec307e930c6b2e60dd51b0a0929a0240f3b896177909118" => :mojave
    sha256 "b9076fa267efcabf04184a8ed20d072c1fd33b753ac2f6883495f2f6b4f8a108" => :high_sierra
    sha256 "cce62f0616d060bf803a5bc83d15907a02b90f5ec3faea62422d8fa179982ab2" => :sierra
    sha256 "e22f894e1224e3c0f85257c5b4db11ed1095b5a2117f48f38653b22a3d395fe4" => :el_capitan
    sha256 "4e921612e3edb452f6a67f41248247d1c5b60aa22ad17d632cd43e62f5d77084" => :yosemite
    sha256 "ad6205419a88e181be9bc8c107b5cd366bb0a60bf4b4b2ec5b3457c64f8060c0" => :mavericks
  end

  patch do
    url "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/m/mmv/mmv_1.01b-15.diff.gz"
    sha256 "9ad3e3d47510f816b4a18bae04ea75913588eec92248182f85dd09bc5ad2df13"
  end

  def install
    system "make", "CC=#{ENV.cc}", "LDFLAGS="

    bin.install "mmv"
    man1.install "mmv.1"

    %w[mcp mad mln].each do |mxx|
      bin.install_symlink "mmv" => mxx
      man1.install_symlink "mmv.1" => "#{mxx}.1"
    end
  end

  test do
    touch testpath/"a"
    touch testpath/"b"
    pipe_output(bin/"mmv", "a b\nb c\n")
    refute_predicate testpath/"a", :exist?
    assert_predicate testpath/"c", :exist?
  end
end
