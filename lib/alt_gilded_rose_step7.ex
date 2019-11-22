defmodule AltGildedRoseStep7 do
  @aged_brie "Aged Brie"
  @backstage_passes "Backstage passes to a TAFKAL80ETC concert"
  @sulfuras "Sulfuras, Hand of Ragnaros"

  def update(items) do
    Enum.map(items, &update_item/1)
  end

  def new_update_item(item) do
    item
    |> age()
    |> update_quality()
    |> constrain_quality()
  end

  def age(%{sell_in: sell_in} = item), do: %{item | sell_in: sell_in - 1}

  def update_quality(%{name: @aged_brie, sell_in: sell_in, quality: quality} = item) do
    updated =
      if sell_in < 0 do
        quality + 2
      else
        quality + 1
      end

    %{item | quality: updated}
  end

  def update_quality(%{sell_in: sell_in, quality: quality} = item) do
    updated =
      if sell_in < 0 do
        quality - 2
      else
        quality - 1
      end

    %{item | quality: updated}
  end

  def constrain_quality(%{quality: quality} = item) when quality < 0, do: %{item | quality: 0}
  def constrain_quality(%{quality: quality} = item) when quality > 50, do: %{item | quality: 50}
  def constrain_quality(item), do: item

  def update_item(%{name: @sulfuras} = item), do: item

  def update_item(%{name: @backstage_passes} = item) do
    quality =
      case item.sell_in do
        days when days <= 0 -> 0
        days when days <= 5 -> item.quality + 3
        days when days <= 10 -> item.quality + 2
        _ -> item.quality + 1
      end
      |> min(50)

    %{item | quality: quality, sell_in: item.sell_in - 1}
  end

  def update_item(item) do
    new_update_item(item)
  end
end
