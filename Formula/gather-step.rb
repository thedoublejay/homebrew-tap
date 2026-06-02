class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.2.1.tar.gz"
  sha256 "568e7f95f6b78fd534c533e373fbc830da37188a7659836189142e500c0fdb49"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.2.1/gather-step-v4.2.1-aarch64-apple-darwin.tar.gz"
    sha256 "148ec95afa040163ff15ace3dde6d0f975266ac6b23dd326a22af4b4303f16ae"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.2.1/gather-step-v4.2.1-x86_64-apple-darwin.tar.gz"
    sha256 "ea7b60951f106638339bcd1e887c79faee54ed45904df132e00ab3ee45cf239d"
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
