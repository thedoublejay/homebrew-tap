class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.4.3.tar.gz"
  sha256 "ddf9f798950664c8eb7f9491d7a364280a3041cd25dc0f11f318d60e39908321"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.3/gather-step-v4.4.3-aarch64-apple-darwin.tar.gz"
    sha256 "bfd3767756de1cf758066b226e3680a8eec1cbea0798f2b10ffa548b0a34abc6"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.3/gather-step-v4.4.3-x86_64-apple-darwin.tar.gz"
    sha256 "8fd2b0ddb802a3b4d2cbd0427db3d2561e90ad43de6bd6ca3b58b7efaeadf00b"
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
