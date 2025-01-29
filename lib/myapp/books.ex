defmodule Myapp.Books do
  alias Myapp.Repo
  alias Myapp.Tag
  alias Myapp.Book
  alias Myapp.BookTag

  # Tags

  def list_tags() do
    Repo.all(Tag)
  end

  def get_tag(id) do
    Repo.get(Tag, id)
  end

  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  # Books

  def list_books() do
    Repo.all(Book)
  end

  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  def update_book(book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  def get_book(id) do
    Repo.get(Book, id)
  end

  # BookTags

  def create_book_tag(book, tag) do
    %BookTag{}
    |> BookTag.changeset(%{book_id: book.id, tag_id: tag.id})
    |> Repo.insert()
  end
end
