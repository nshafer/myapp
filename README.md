# Adding, removing, updating Tags for Books with `put_assoc`

Uses a `many_to_many` association to model the many-to-many relationship (with association table) in the db.


```elixir
  schema "books" do
    many_to_many :tags, Myapp.Tag, join_through: Myapp.BookTag, on_replace: :delete
  end
```

And then `put_assoc` along with a helper function to update the associated tags via either a list of tag schemas or ids.

```elixir
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
```

## Pros:
    
- You can just give a list of tags or tag_ids and it will update the Book's tags to match that list.
- There is only one association on a `Book`, which is updated by insert and update operations.
- With just `:tags` there is less loaded data on the Book than the cast method, which has `:book_tags` and `:tags`.

## Cons:

- This will only work with "naive" associations, that don't have any extra data for each association, since this uses many_to_many.
- Requires the `cast_tags` helper function in Book.

## Compare

Summary of changes: https://github.com/nshafer/myapp/compare/main...books_put?diff=unified

See also `cast_assoc` method: https://github.com/nshafer/myapp/compare/main...books_cast?diff=unified

Compare to `cast_assoc` method: https://github.com/nshafer/myapp/compare/books_cast...books_put?diff=split
