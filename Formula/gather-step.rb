class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.4.1.tar.gz"
  sha256 "506a85e43aac2f701fc5d4567bbb2a0143ae569debac6356caae44a593603e16"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.1/gather-step-v4.4.1-aarch64-apple-darwin.tar.gz"
    sha256 "3d30f4b93771f3d6fcef82537cdaab94a5cef493c6e913ea544750c734edd19f"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.1/gather-step-v4.4.1-x86_64-apple-darwin.tar.gz"
    sha256 "3d8f2afd8540c11f0e66c05a24ef44aaf14047fd6f352088c893fac1b2088b59"
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
