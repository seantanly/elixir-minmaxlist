defmodule Minmaxlist.Mixfile do
  use Mix.Project

  @version "0.0.5"

  def project do
    [
      app: :minmaxlist,
      version: @version,
      elixir: "~> 1.1",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      package: package,
      name: "Minmaxlist",
      source_url: "https://github.com/seantanly/elixir-minmaxlist",
      homepage_url: "https://github.com/seantanly/elixir-minmaxlist",
      description: """
      Elixir library extending `Enum.min_by/2`, `Enum.max_by/2` and `Enum.min_max_by/2` to return a list of results instead of just one.
      """,
      docs: docs,
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:credo, ">= 0.0.0", only: [:dev, :test]},
      {:earmark, ">= 0.2.1", only: :docs},
      {:ex_doc, ">= 0.0.0", only: :docs},
    ]
  end

  defp package do
    [
      maintainers: ["Sean Tan Li Yang"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/seantanly/elixir-minmaxlist"},
      files: ~w(lib test) ++
             ~w(CHANGELOG.md LICENSE mix.exs README.md),
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      main: "Minmaxlist",
      # logo: "path/to/logo.png",
      extras: ~w(CHANGELOG.md README.md LICENSE.md)
    ]
  end
end
