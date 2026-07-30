class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.16.1.tar.gz"
  sha256 "b9eb3dcfa1d208595007bb7b2c56512c9da43bafe81ca7bb09f4c402e574a23c"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.16.1/gather-step-v5.16.1-aarch64-apple-darwin.tar.gz"
    sha256 "500af112c2fe0c4d6f20b90498fa4a93fdc814bdb633619e2fa404c5048afee9"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.16.1/gather-step-v5.16.1-x86_64-apple-darwin.tar.gz"
    sha256 "a7fba03e8ba0354f76983d016c6c7264cd5dfac7b4ecf64e4ac5173af3332cbc"
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
