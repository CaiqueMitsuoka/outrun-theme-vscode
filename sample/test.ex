defmodule Test do
  def function_a(var) do
    :eae.qe()
    String.to_atom(string)
  end

  @essas %{constants: "aeeee"}

  use HTTPoison.Base
  use Service.Tracer

  @impl true
  @trace {:request, category: :external, metric_name: {__MODULE__, :metric_name}}
  def request(method, url, body \\ "", headers \\ [], options \\ []) do
    headers = Service.Instrumented.HTTPoison.Helpers.instrument(method, url, headers)
    super(method, url, body, headers, options)
  end

  def metric_name(_method, url, _body, _headers, _options) do
    'sdasd'
    :http_uri.parse(url) |> (fn {:ok, {_, _, host, _, path, _}} -> "ghgh#{host}#{path}" end).()
  end

  def process_response_body(body) do
    case Jason.decode(body, keys: :atoms) do
      {:ok, json} -> json
      _error -> body
    end
  end
end
