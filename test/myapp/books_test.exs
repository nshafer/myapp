defmodule Myapp.BooksTest do
  use Myapp.DataCase

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
    book = BooksFixtures.book_fixture(%{tags: []})

    # Update the Book with a new tag
    attrs = %{
      tag_ids: [tag.id]
    }

    assert {:ok, %Book{} = book} = Books.update_book(book, attrs)

    assert [tag] == book.tags
  end

  test "we're able to remove tags from a book" do
    tag = BooksFixtures.tag_fixture()
    book = BooksFixtures.book_fixture(%{tags: [tag]})

    # Update the Book with an empty list of tags
    assert {:ok, %Book{} = book} = Books.update_book(book, %{tags: []})

    assert [] == book.tags
  end
end
