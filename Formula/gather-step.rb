class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.8.0.tar.gz"
  sha256 "061607452f259c9b7fb805ca4858262064d43c1226c0fd9c1b07001a85b9a385"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.8.0/gather-step-v5.8.0-aarch64-apple-darwin.tar.gz"
    sha256 "00aa7b7818f6ea09124e37dfe1eb304bda73109a40cdd4df6f29eaa8f6b0919d"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.8.0/gather-step-v5.8.0-x86_64-apple-darwin.tar.gz"
    sha256 "d23536447cca751dfd0d897a7a6638e62f10a12ce6279d6e9c57e87bf154b7f3"
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
