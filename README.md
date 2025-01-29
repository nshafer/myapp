# Adding, removing, updating Tags for Books with `cast_assoc`

Uses a "multi-level" `has_many` association to model the many-to-many relationship (with association table) in the db.

```elixir
  schema "books" do
    has_many :book_tags, Myapp.BookTag, on_replace: :delete
    has_many :tags, through: [:book_tags, :tag]
  end
```

And then `cast_assoc` to cast the `PostTag` when inserting and updating the parent `Book`.

```elixir
cast_assoc(changeset, :book_tags, with: &Myapp.BookTag.assoc_changeset/2)
```

## Pros:

- Supports complex association tables well. (where you have more than just the ids, such as extra information related to the association.)
- Preloading :tags will also preload :book_tags. Also, if :book_tags is already preloaded, then preloading :tags does not hit the database.

Cons:

- Requires a list of maps as params, e.g. `%{book_tags: [%{tag_id: tag.id}]}`, so it doesn't work very well with just a list of ids.
- Some operations, such as insert and update, only update the book_tags relation, so you have to preload :tags still.

## Compare

Summary of changes: https://github.com/nshafer/myapp/compare/main...books_cast?diff=unified

See also `put_assoc` method: https://github.com/nshafer/myapp/compare/main...books_put?diff=unified

Compare to `put_assoc` method: https://github.com/nshafer/myapp/compare/books_cast...books_put?diff=split
