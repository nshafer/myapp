defmodule Myapp.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :name, :string

      timestamps()
    end

    create table(:tags) do
      add :name, :string

      timestamps()
    end

    create unique_index(:tags, [:name])

    create table(:books_tags, primary_key: false) do
      add :book_id, references(:books, on_delete: :delete_all), primary_key: true
      add :tag_id, references(:tags, on_delete: :delete_all), primary_key: true

      timestamps()
    end
  end
end
