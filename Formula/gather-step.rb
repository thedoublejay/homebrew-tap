class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.17.0.tar.gz"
  sha256 "0bebdfb39375b1e08233d88a7ab5ca45a245c72876045a8ea521bbd376008ba8"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.17.0/gather-step-v5.17.0-aarch64-apple-darwin.tar.gz"
    sha256 "4025afff4905699258eb8dbacf714e555f78270961d9ae0bcabcbc71a9e5ffd4"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.17.0/gather-step-v5.17.0-x86_64-apple-darwin.tar.gz"
    sha256 "2241ab71be76602e5d2d730c2dee3f16fd406b236768122ccfeac542893f8c2a"
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
