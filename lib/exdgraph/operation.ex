defmodule ExDgraph.Operation do
  @moduledoc """
  Provides the functions for the callbacks from the DBConnection behaviour.
  """
  alias ExDgraph.{Exception, OperationStatement}

  @doc false
  def operation(conn, operation) do
    case operation_commit(conn, operation) do
      {:error, f} ->
        {:error, code: f.code, message: f.message}

      r ->
        {:ok, r}
    end
  end

  @doc false
  def operation!(conn, operation) do
    case operation(conn, operation) do
      {:ok, r} ->
        r

      {:error, code: code, message: message} ->
        raise Exception, code: code, message: message
    end
  end

  defp operation_commit(conn, operation) do
    operation_processed =
      operation
      |> Map.put_new(:drop_all, false)
      |> Map.put_new(:drop_attr, "")
      |> Map.put_new(:schema, "")

    exec = fn conn ->
      operation = %OperationStatement{
        drop_all: operation_processed.drop_all,
        drop_attr: operation_processed.drop_attr,
        schema: operation_processed.schema
      }

      case DBConnection.execute(conn, operation, %{}) do
        {:ok, resp} -> resp
        other -> other
      end
    end

    # Response.transform(DBConnection.run(conn, exec, run_opts()))
    DBConnection.run(conn, exec, run_opts())
  end

  defp run_opts do
    [pool: ExDgraph.config(:pool)]
  end
end
