class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.15.1.tar.gz"
  sha256 "4fa0d47a39e59e3d012bc0da0fc0e8123dde79be987e497369a66a6b5a1bffa9"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.15.1/gather-step-v5.15.1-aarch64-apple-darwin.tar.gz"
    sha256 "931fbd0f2006353c1b4991a6c2e1920a053df76de47711f33beb43e97936aac0"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.15.1/gather-step-v5.15.1-x86_64-apple-darwin.tar.gz"
    sha256 "8dcf22abb0ba698e893f52ad5ba67dd96c0047bd2c71d64b0ff05eb8e30369ea"
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
