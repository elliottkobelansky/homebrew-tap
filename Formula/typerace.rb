class Typerace < Formula
  desc "TypeRacer-style typing races in the terminal"
  homepage "https://github.com/elliottkobelansky/typerace"
  url "https://github.com/elliottkobelansky/typerace/releases/download/v0.1.0/typerace-0.1.0.tar.gz"
  sha256 "35332ef5b2b50c509c6cb52241fd4fa49b3b6cb0898b8004aa47b54d64c43a91"
  license "GPL-3.0-or-later"

  depends_on "python@3.13"

  def install
    # pure Python with no dependencies: install the package and a launcher
    libexec.install "src/typerace"
    (bin/"typerace").write <<~SH
      #!/bin/sh
      PYTHONPATH="#{libexec}" exec "#{Formula["python@3.13"].opt_bin}/python3.13" -m typerace "$@"
    SH
    chmod 0755, bin/"typerace"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/typerace --version")
    assert_match "no races yet", shell_output("XDG_DATA_HOME=#{testpath} #{bin}/typerace --history")
  end
end
