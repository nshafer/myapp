defmodule Myapp.Book do
  use Ecto.Schema

  import Ecto.Changeset

  schema "books" do
    field :name, :string

    # many_to_many :tags, Myapp.Tag, join_through: Myapp.BookTag, on_replace: :delete
    has_many :book_tags, Myapp.BookTag, on_replace: :delete
    has_many :tags, through: [:book_tags, :tag]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:book_tags, with: &Myapp.BookTag.assoc_changeset/2)
  end
end
