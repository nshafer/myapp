defmodule Myapp.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias Myapp.Books

  schema "books" do
    field :name, :string

    many_to_many :tags, Myapp.Tag, join_through: Myapp.BookTag, on_replace: :delete
    # has_many :book_tags, Myapp.BookTag, on_replace: :delete
    # has_many :tags, through: [:book_tags, :tag]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_tags(attrs)
  end

  defp cast_tags(changeset, %{"tags" => tags}) do
    put_assoc(changeset, :tags, tags)
  end

  defp cast_tags(changeset, %{tags: tags}) do
    put_assoc(changeset, :tags, tags)
  end

  defp cast_tags(changeset, %{"tag_ids" => tags}) do
    put_assoc(changeset, :tags, Books.get_tags(tags))
  end

  defp cast_tags(changeset, %{tag_ids: tags}) do
    put_assoc(changeset, :tags, Books.get_tags(tags))
  end

  defp cast_tags(changeset, _attrs), do: changeset
end
