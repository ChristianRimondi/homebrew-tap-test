class GeckodriverAT0191 < Formula
  desc "WebDriver <-> Marionette proxy"
  homepage "https://github.com/mozilla/geckodriver"
  head "https://hg.mozilla.org/mozilla-central/", :using => :hg

  stable do
    url "https://github.com/mozilla/geckodriver/archive/v0.19.1.tar.gz"
    sha256 "f590ddfef42995a23e781b52befdbc2ac342bf829008e98d212f2e1e15d9f713"

    # Remove for > 0.19.1
    # Fixes E0277 when building slog with Rust > 1.23
    # Fixed upstream in https://hg.mozilla.org/mozilla-central/rev/cbd3741a4bb0 on 2018-02-15.
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/e89f1ad/geckodriver/bug-1435830.patch"
      sha256 "578cdb22803c2f6ee00e8e0b1ca6fcde622c743572aad7038dda0d63cbce4500"
    end
  end

  depends_on "rust" => :build

  def install
    dir = build.head? ? "testing/geckodriver" : "."
    cd(dir) { system "cargo", "build" }
    bin.install "target/debug/geckodriver"
    bin.install_symlink bin/"geckodriver" => "wires"
  end

  test do
    system bin/"geckodriver", "--help"
  end
end
