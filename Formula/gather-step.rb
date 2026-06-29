class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.6.0.tar.gz"
  sha256 "fd164807e47e1c3eb13d0f60bb7c9fafc54c12eeabf9c32417eb752ca826f7cc"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.6.0/gather-step-v5.6.0-aarch64-apple-darwin.tar.gz"
    sha256 "70e0baf4cdc9caa674866801d4a0c3105d796a085020fea2cea3dff435fcc62e"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.6.0/gather-step-v5.6.0-x86_64-apple-darwin.tar.gz"
    sha256 "44f66e6b9f90f34001edb13f9fc22ca7cf8da1338833c007acdf87c7667f9eb9"
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
