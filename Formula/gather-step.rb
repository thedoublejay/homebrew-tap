class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.12.0.tar.gz"
  sha256 "f1a5e17911fd9029ae5fc26e1a33c62a901b4261c66b2859be729522d9dfa30a"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.12.0/gather-step-v5.12.0-aarch64-apple-darwin.tar.gz"
    sha256 "da6c440a414f2a7a14b8f260a484827b7c2eb10f014eba445617a6da82bcba19"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.12.0/gather-step-v5.12.0-x86_64-apple-darwin.tar.gz"
    sha256 "37e0ddc82c2eb477621a7c79104061c5744cb1c7533f0ab732c76d6bddd8a808"
  end

  def install
    if OS.mac?
      arch = Hardware::CPU.arm? ? "aarch64-apple-darwin" : "x86_64-apple-darwin"
      resource("gather-step-#{arch}").stage do
        bin.install "gather-step-#{arch}" => "gather-step"
      end
    else
      system "cargo", "install", *std_cargo_args(path: "crates/gather-step-cli")
    end
  end

  test do
    system "git", "init"
    system bin/"gather-step", "--workspace", testpath, "--no-banner", "--no-interactive", "init"

    assert_path_exists testpath/"gather-step.config.yaml"
  end
end
