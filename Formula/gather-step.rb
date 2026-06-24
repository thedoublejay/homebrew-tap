class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.4.0.tar.gz"
  sha256 "78effffa1f55c903e965cf8137549f264031a8810a95864637ea0f297a78e5c3"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.4.0/gather-step-v5.4.0-aarch64-apple-darwin.tar.gz"
    sha256 "8632b498da84ade186d71c4f8347f339e315005d91b1f60d64033d326d987376"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.4.0/gather-step-v5.4.0-x86_64-apple-darwin.tar.gz"
    sha256 "fcff984d99dd04bccb6919700a95f235a8bc8031ede85bf5e5cdfb78d40b1a99"
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
