class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.3.0.tar.gz"
  sha256 "59c08cfd3cdd7038c2b82f5dec2eebdd9f9765fb19feafabd452ba597322ac13"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.3.0/gather-step-v4.3.0-aarch64-apple-darwin.tar.gz"
    sha256 "18edc42b0791d58acaebd0d8b03cb5758628c4de687a3cf25ceebd53795abfdf"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.3.0/gather-step-v4.3.0-x86_64-apple-darwin.tar.gz"
    sha256 "3f3017602397a41633307ceb2127889cf7acbdd2e8d9cc4044cb33f6d4ae0d80"
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
