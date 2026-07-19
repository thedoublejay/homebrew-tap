class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.16.0.tar.gz"
  sha256 "f08c47a12dd63026ab69d955c886848520a32b9378d00f6c928397b7524ed44d"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.16.0/gather-step-v5.16.0-aarch64-apple-darwin.tar.gz"
    sha256 "f588f866a4d626c291cc73c2c701688a6ce78920a57626547cba93cfb0c08b9b"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.16.0/gather-step-v5.16.0-x86_64-apple-darwin.tar.gz"
    sha256 "8897261f513c145927ca17ea45bba541f90ae7809cc4feb015bf41984e73a59b"
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
