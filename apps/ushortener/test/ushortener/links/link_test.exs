defmodule Ushortener.Links.LinkTest do
  use Ushortener.DataCase

  alias Ushortener.Links
  alias Ushortener.Links.Link

  describe "generate_short_code/0" do
    test "generate short code correctly" do
      short_code = Link.generate_short_code()
      assert String.length(short_code) == 6
    end
  end

  describe "create_link/1" do
    test "create a new link successfully" do
      short_code = Link.generate_short_code()

      assert {:ok, %Link{short_code: ^short_code}} =
               Links.create_link(%{
                 url: "http://test.com",
                 short_code: short_code
               })
    end

    test "return error when trying to create the same short code" do
      short_code = Link.generate_short_code()

      assert {:ok, %Link{short_code: ^short_code}} =
               Links.create_link(%{
                 url: "http://test.com",
                 short_code: short_code
               })

      assert {:error, %Ecto.Changeset{errors: [short_code: {"has already been taken", _}]}} =
               Links.create_link(%{
                 url: "http://test2.com",
                 short_code: short_code
               })
    end
  end

  describe "get_by_short_code/1" do
    setup do
      short_code = Link.generate_short_code()

      {:ok, link} =
        Links.create_link(%{
          url: "http://test.com",
          short_code: short_code
        })

      [short_code: short_code, link: link]
    end

    test "returns the link when found the short code", %{short_code: short_code} do
      assert %Link{short_code: ^short_code} = Links.get_by_short_code(short_code)
    end

    test "returns nil when short code not found" do
      assert Links.get_by_short_code("a1B2c3") |> is_nil()
    end
  end
end
