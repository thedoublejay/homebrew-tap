class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.4.1.tar.gz"
  sha256 "2be28eee856eaa1fb58fe1d65f444dfb29369cd9036a49883b576e5c4e0448b2"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.4.1/gather-step-v5.4.1-aarch64-apple-darwin.tar.gz"
    sha256 "ef0defe35f0ae3c32fa995fbc558b880c3ea5352eeaa5de6dc7f82c440f3e442"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.4.1/gather-step-v5.4.1-x86_64-apple-darwin.tar.gz"
    sha256 "73b77a53fea0af12a0d5f1833745649496febf0da3bbdacb1284532e5aae2031"
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
