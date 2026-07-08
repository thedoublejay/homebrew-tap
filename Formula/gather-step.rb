class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.14.0.tar.gz"
  sha256 "77cb7c000eba91b0f0401cab9227945f180c212aeb6a218133ce8502272f3ea0"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.14.0/gather-step-v5.14.0-aarch64-apple-darwin.tar.gz"
    sha256 "5df30f8a1e570d9256a880f945afa4744ceae04b467e9e052a9694a3e0d5f54f"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.14.0/gather-step-v5.14.0-x86_64-apple-darwin.tar.gz"
    sha256 "0f08fe91f1349d76666163fc4446bacad2d9da2c4542907604f600830d535bff"
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
