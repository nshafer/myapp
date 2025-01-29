defmodule Myapp.BookTag do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  schema "books_tags" do
    belongs_to :book, Myapp.Book, primary_key: true
    belongs_to :tag, Myapp.Tag, primary_key: true

    timestamps(type: :utc_datetime)
  end

  def changeset(book_tag, attrs) do
    book_tag
    |> cast(attrs, [:book_id, :tag_id])
    |> validate_required([:book_id, :tag_id])
  end
end
