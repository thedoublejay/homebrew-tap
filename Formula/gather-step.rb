class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://github.com/thedoublejay/gather-step"
  url "https://github.com/thedoublejay/gather-step.git",
      revision: "c7d210c640158fc43ea10747e9d8f700d90ece21"
  version "1.0.0"
  license "MIT"
  head "https://github.com/thedoublejay/gather-step.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/gather-step-cli")

    pkgshare.install "gather-step.config.yaml.example", "gather-step.local.example.yaml"
  end

  test do
    system "git", "init"
    system bin/"gather-step", "--workspace", testpath, "--no-banner", "init"

    assert_path_exists testpath/"gather-step.config.yaml"
  end
end
