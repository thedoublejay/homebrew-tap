class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.0.5.tar.gz"
  sha256 "49ce56c9138917a735ab213711ccc396674311fc42cce423314e12863c014e69"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.5/gather-step-v4.0.5-aarch64-apple-darwin.tar.gz"
    sha256 "3c4ca5ca265f7f4ea9eca0e0f7bf67a75e1e6cda9ff3ab3ceec830e67f71f379"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.5/gather-step-v4.0.5-x86_64-apple-darwin.tar.gz"
    sha256 "8f0c9aef30b26d0e539d22c0fab24c4680ca1681ad53221457d9f749c208ee56"
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
