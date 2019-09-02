defmodule ExDgraph.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_dgraph,
      version: "0.2.0-beta.3",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "ExDgraph",
      source_url: "https://github.com/ospaarmann/exdgraph",
      # The main page in the docs
      docs: [main: "ExDgraph", extras: ["README.md"]],
      # ExCoveralls
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:logger, :db_connection, :grpc]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:db_connection, "~> 2.1"},
      {:elixir_uuid, "~> 1.2"},
      {:grpc, "~> 0.3.1"},
      {:jason, "~> 1.1"},
      {:morphix, "~> 0.6.0"},
      {:protobuf, "~> 0.6.1"},
      {:excoveralls, "~> 0.10", only: :test},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "> 0.0.0", only: :dev, runtime: false},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    A gRPC based Dgraph client for Elixir.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Ole Spaarmann"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/ospaarmann/exdgraph"}
    ]
  end
end
