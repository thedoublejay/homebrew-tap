class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.15.0.tar.gz"
  sha256 "a539f9011ab5361be79ff8c8d953a54d0485ab54312c6ef67dbb97ac9e630b0a"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.15.0/gather-step-v5.15.0-aarch64-apple-darwin.tar.gz"
    sha256 "ea1cdab827942fb842729f72848f6446941b1459c13e4084031454b9797b0c19"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.15.0/gather-step-v5.15.0-x86_64-apple-darwin.tar.gz"
    sha256 "59e3c5a060840f32505e3a83e4294c3cae346627cd05974e5caf170dec94322a"
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
