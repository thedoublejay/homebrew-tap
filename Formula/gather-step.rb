class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.14.1.tar.gz"
  sha256 "7138d1448acd882429489562c58adf8b4a8065bb5e02c2113d227f56c2ad78a8"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.14.1/gather-step-v5.14.1-aarch64-apple-darwin.tar.gz"
    sha256 "c87479317228090c95cd0ba8af8ec93d101445ccb9d9bfc2d3b3ca278c41e5e0"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.14.1/gather-step-v5.14.1-x86_64-apple-darwin.tar.gz"
    sha256 "d8eb3668892a75031bab51874e106de246927b408b253099fd2ec9cb1da994e5"
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
