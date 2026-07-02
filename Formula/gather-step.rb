class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.9.0.tar.gz"
  sha256 "4a61768ec3f4b0f5f9fa18dc0c6b4d8aa21698689bddea0c2d6e01c1dc8bf7eb"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.9.0/gather-step-v5.9.0-aarch64-apple-darwin.tar.gz"
    sha256 "b57fa9e3a172d5db284ec9e307bcfc2eac4fe470b3d8d8b962657cce21ab82d6"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.9.0/gather-step-v5.9.0-x86_64-apple-darwin.tar.gz"
    sha256 "64ebee3cc5617451c88a6c978f275f8d8b620fa74142c9dcacd2874d83662055"
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
