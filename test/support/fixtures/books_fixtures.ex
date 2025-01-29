defmodule Myapp.BooksFixtures do
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        name: "fiction"
      })
      |> Myapp.Books.create_tag()

    tag
  end

  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        name: "The Hobbit"
      })
      |> Myapp.Books.create_book()

    book
  end
end
