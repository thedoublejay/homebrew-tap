class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.16.3.tar.gz"
  sha256 "1fb0e38937013a75dca1547e6ac4e68737403f92e2143f4f0a079c480d1ffbe2"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.16.3/gather-step-v5.16.3-aarch64-apple-darwin.tar.gz"
    sha256 "2dd5fde39838aab00709e3159d9b6759149d4d909ef025c2feb0340f66403a88"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.16.3/gather-step-v5.16.3-x86_64-apple-darwin.tar.gz"
    sha256 "18c329ad16c7c36045d5b089de586051f8e64fb90f7bc22a1ba5de8e981930b9"
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
