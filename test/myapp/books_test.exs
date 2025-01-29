defmodule Myapp.BooksTest do
  use Myapp.DataCase

  alias Myapp.Repo
  alias Myapp.Books
  alias Myapp.Book
  alias Myapp.BooksFixtures

  test "we're able to create a book with tags" do
    tag = BooksFixtures.tag_fixture()

    # Since `cast_assoc` only works on existing Books, we can't create a Book with tags in one go.
    {:ok, book} = Books.create_book(%{name: "The Hobbit"})

    # Now create the BookTag association between the book and the tag
    {:ok, _book_tag} = Books.create_book_tag(book, tag)

    # Reload the book with the `:tags` association
    book = Books.get_book(book.id) |> Repo.preload(:tags)

    assert [tag] == book.tags
  end

  test "we're able to add a tag to a book" do
    tag = BooksFixtures.tag_fixture()
    book = BooksFixtures.book_fixture()

    # The newly created book does not have the `:book_tags` or `:tags` associations
    # loaded, so load them. Loading `:tags` will also load it's dependent, `:book_tags`.
    book = Repo.preload(book, :tags)

    # Casting the `:book_tags` association requires setting all fields of it.
    attrs = %{
      book_tags: [%{book_id: book.id, tag_id: tag.id}]
    }

    assert {:ok, %Book{} = book} = Books.update_book(book, attrs)

    # The updated `book` has updated `book_tags` but not updated `tags` associations,
    # so we have to preload `:tags` again
    book = Repo.preload(book, :tags)

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
    assert {:ok, %Book{} = book} = Books.update_book(book, %{book_tags: []})

    # The updated `book` has updated `book_tags` but not updated `tags` associations,
    # so we have to preload `:tags` again
    book = Repo.preload(book, :tags)

    assert [] == book.tags
  end
end
