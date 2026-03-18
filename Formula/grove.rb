class Grove < Formula
  desc "Zero-friction worktree management for developers"
  homepage "https://github.com/lost-in-the/grove"
  url "https://github.com/lost-in-the/grove/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "a81cf0808680a4b299b89f43d6f9cc2fec8703f88947c3383ae187f088480003"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/lost-in-the/grove/internal/version.Version=#{version}
      -X github.com/lost-in-the/grove/internal/version.Commit=HEAD
      -X github.com/lost-in-the/grove/internal/version.BuildDate=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/grove"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/grove version")
  end

  def caveats
    <<~EOS
      To enable grove, add this to your shell configuration:

      For zsh (~/.zshrc):
        eval "$(grove install zsh)"

      For bash (~/.bashrc):
        eval "$(grove install bash)"

      Then reload your shell:
        source ~/.zshrc  # or ~/.bashrc
    EOS
  end
end
