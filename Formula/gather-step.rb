class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.4.4.tar.gz"
  sha256 "4303f19f1c62a618f59b93b58e1f40d2282e61513ec396b08a821eedbffef2aa"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.4/gather-step-v4.4.4-aarch64-apple-darwin.tar.gz"
    sha256 "6d454b50a9186cad68850f9dff68e07fcca3aa80443cabe83ce595190dd134ee"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.4/gather-step-v4.4.4-x86_64-apple-darwin.tar.gz"
    sha256 "ee398a43fb3b114d797723c8759c1cc0207b5072ab7d9e0290a0ba8dcc492e93"
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
