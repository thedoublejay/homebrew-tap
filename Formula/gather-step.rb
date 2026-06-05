class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.4.0.tar.gz"
  sha256 "1b69e43f9dc0cdc778f22d6fa9ab195e79a3f7a5fd7504397cf29fdd2eaaa914"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.0/gather-step-v4.4.0-aarch64-apple-darwin.tar.gz"
    sha256 "3ed062403b50e0c3f634d3ed7bc8aa4a4f3c401a67df51c111943e5d39de95d5"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.0/gather-step-v4.4.0-x86_64-apple-darwin.tar.gz"
    sha256 "7ae7d63670cbb56b7ade28a4131b022dd3ed2f3d3ca9273148bf940a63b5f923"
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
