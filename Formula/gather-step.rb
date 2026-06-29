class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.7.0.tar.gz"
  sha256 "3663341f68871f43f720c2bd9b88f77f9bb1960c56844bec939c562d9647ff43"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.7.0/gather-step-v5.7.0-aarch64-apple-darwin.tar.gz"
    sha256 "c43a6aad9d0a33eb5e939d58633b384691f165d3bb978aad7c8c3b0bb8ae8376"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.7.0/gather-step-v5.7.0-x86_64-apple-darwin.tar.gz"
    sha256 "cdca9110c2745cbe6f0c321db16534bd8a555ed05bdd9978773403121867969d"
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
