defmodule Apostila.MixProject do
  use Mix.Project

  def project do
    [
      app: :apostila,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mox, "~> 0.5.2", only: :test},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:flow, github: "plataformatec/flow", ref: "cbea6aa75f47d9278ab02d6034b213b991cc8a92"}
    # optional, but recommended adapter
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
