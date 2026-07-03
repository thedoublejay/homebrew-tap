class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.10.0.tar.gz"
  sha256 "96f1e874816b5530db34addddc8c54bc0097f63bc7db5731fd37d730a98a2529"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.10.0/gather-step-v5.10.0-aarch64-apple-darwin.tar.gz"
    sha256 "69ac407fa4bd2ab538ecb9bcea502d8e0fd8fa0ae620ce8ffb8d30c05c48e9a3"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.10.0/gather-step-v5.10.0-x86_64-apple-darwin.tar.gz"
    sha256 "9d5d5913d1c47a7af66d17cdf35aca92b656ed1bcd7c37fcfa07ba47ef7308d0"
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
