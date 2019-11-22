defmodule AltGildedRoseOptional do
  @aged_brie "Aged Brie"
  @backstage_passes "Backstage passes to a TAFKAL80ETC concert"
  @sulfuras "Sulfuras, Hand of Ragnaros"

  def update(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%{name: @sulfuras} = item), do: item

  def update_item(item) do
    item
    |> age()
    |> update_quality()
    |> constrain_quality()
  end

  def age(%{sell_in: sell_in} = item), do: %{item | sell_in: sell_in - 1}

  def update_quality(%{name: @aged_brie, sell_in: sell_in, quality: quality} = item)
      when sell_in < 0,
      do: %{item | quality: quality + 2}

  def update_quality(%{name: @aged_brie, quality: quality} = item),
    do: %{item | quality: quality + 1}

  def update_quality(%{name: @backstage_passes, sell_in: sell_in} = item) when sell_in < 0,
    do: %{item | quality: 0}

  def update_quality(%{name: @backstage_passes, sell_in: sell_in, quality: quality} = item)
      when sell_in < 5,
      do: %{item | quality: quality + 3}

  def update_quality(%{name: @backstage_passes, sell_in: sell_in, quality: quality} = item)
      when sell_in < 10,
      do: %{item | quality: quality + 2}

  def update_quality(%{name: @backstage_passes, quality: quality} = item),
    do: %{item | quality: quality + 1}

  def update_quality(%{sell_in: sell_in, quality: quality} = item) when sell_in < 0,
    do: %{item | quality: quality - 2}

  def update_quality(%{quality: quality} = item), do: %{item | quality: quality - 1}

  def constrain_quality(%{quality: quality} = item) when quality < 0, do: %{item | quality: 0}
  def constrain_quality(%{quality: quality} = item) when quality > 50, do: %{item | quality: 50}
  def constrain_quality(item), do: item
end
