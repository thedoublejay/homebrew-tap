class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.1.0.tar.gz"
  sha256 "7ca80fdf12da8c9bc15374152912656088e2b2ba7292afcb12cc4af48ed10e8a"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.1.0/gather-step-v4.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "2a44b36800f38d2c256a352479e8883774616be701a87272bd7b1da0b12ca561"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.1.0/gather-step-v4.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "4306d42ae5862bf3137252d545564067f3d169410e583e901bfc10cc4abc1bb9"
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
