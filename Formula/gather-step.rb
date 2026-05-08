class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.0.4.tar.gz"
  sha256 "7a084fcd016c81bee30de9750a3b386b6ca2804d1580648fd6f0a9d3eca3acf8"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.4/gather-step-v4.0.4-aarch64-apple-darwin.tar.gz"
    sha256 "026fa30ac0cde6240ba4d4bc85f93208060c01ac42d8ad225fa0d41bb27e70c5"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.4/gather-step-v4.0.4-x86_64-apple-darwin.tar.gz"
    sha256 "fb7f056ccf47b5fa06c82cd4974fb155197d0e90aa3494b189de559662361e18"
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
