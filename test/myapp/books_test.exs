defmodule Myapp.BooksTest do
  use Myapp.DataCase

  alias Myapp.Repo
  alias Myapp.Books
  alias Myapp.Book
  alias Myapp.BooksFixtures

  test "we're able to create a book with tags" do
    tag = BooksFixtures.tag_fixture()

    {:ok, book} =
      Books.create_book(%{
        name: "The Hobbit",
        tags: [tag]
      })

    assert [tag] == book.tags
  end

  test "we're able to add a tag to a book" do
    tag = BooksFixtures.tag_fixture()
    book = BooksFixtures.book_fixture()

    # The newly created book does not have the `:tags` associations loaded, so load it
    book = Repo.preload(book, :tags)

    # Update the Book with a new tag
    attrs = %{
      tag_ids: [tag.id]
    }

    assert {:ok, %Book{} = book} = Books.update_book(book, attrs)

    assert [tag] == book.tags
  end

  test "we're able to remove tags from a book" do
    tag = BooksFixtures.tag_fixture()
    book = BooksFixtures.book_fixture()

    # Create a BookTag association between the book and the tag
    {:ok, _book_tag} = Books.create_book_tag(book, tag)

    # Reload the book with the `:tags` association
    book = Books.get_book(book.id) |> Repo.preload(:tags)

    # Update the Book with an empty list of tags
    assert {:ok, %Book{} = book} = Books.update_book(book, %{tags: []})

    assert [] == book.tags
  end
end
