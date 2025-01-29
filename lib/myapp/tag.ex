defmodule Myapp.Tag do
  use Ecto.Schema

  import Ecto.Changeset

  schema "tags" do
    field :name, :string

    # many_to_many :books, Myapp.Book, join_through: Myapp.BookTag
    has_many :book_tags, Myapp.BookTag
    has_many :books, through: [:book_tags, :book]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unsafe_validate_unique(:name, Myapp.Repo)
    |> unique_constraint(:name)
  end
end
