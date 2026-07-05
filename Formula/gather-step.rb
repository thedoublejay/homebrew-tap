class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.13.0.tar.gz"
  sha256 "e696f33f7d2f1b5cdcd82c49d957bc80d63617780eae34b54db84cf08b3474bb"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.13.0/gather-step-v5.13.0-aarch64-apple-darwin.tar.gz"
    sha256 "e80b7ab3bf0448774d360c2ac04f9c66a9e0abb8bd60f256bae15ef18d3cc280"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.13.0/gather-step-v5.13.0-x86_64-apple-darwin.tar.gz"
    sha256 "f12edac693acb1452d4bf9add468872754627b79cae2a7d8ee790e6e3f0d4abc"
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
