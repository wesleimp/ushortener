defmodule UshortenerWeb.LinksView do
  use UshortenerWeb, :view

  defp validation_class(true), do: "border-green-600"
  defp validation_class(false), do: "border-red-600"
  defp validation_class(_), do: "border-gray-600"
end
