class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.1.1.tar.gz"
  sha256 "f0a27ae9005f2a62ee0526ca7a9840a430fff0fcd9a6ae55b5c4c23387962267"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.1.1/gather-step-v4.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "601472199de859711feeef38bc403dcfebb392fdf577497678680156477f3a7b"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.1.1/gather-step-v4.1.1-x86_64-apple-darwin.tar.gz"
    sha256 "cdf950db4d8ce757b8d41f089e40bc7d42f52afd6ba01e1e5136457347a5d993"
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
