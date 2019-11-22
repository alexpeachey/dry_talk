defmodule GildedRoseStep7 do
  @aged_brie "Aged Brie"
  @backstage_passes "Backstage passes to a TAFKAL80ETC concert"
  @sulfuras "Sulfuras, Hand of Ragnaros"

  def update(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%{name: @aged_brie} = item) do
    do_update(item, 1)
  end

  def update_item(%{name: @backstage_passes} = item) do
    quality = calculate_expiring_quality(item.quality, item.sell_in)
    %{item | quality: quality, sell_in: item.sell_in - 1}
  end

  def update_item(%{name: @sulfuras} = item), do: item

  def update_item(item) do
    do_update(item, -1)
  end

  def do_update(item, modifier) do
    sell_in = item.sell_in - 1
    quality = calculate_quality(item.quality, sell_in, modifier)
    %{item | quality: quality, sell_in: sell_in}
  end

  def calculate_quality(quality, sell_in, modifier) do
    if sell_in < 0 do
      quality + 2 * modifier
    else
      quality + 1 * modifier
    end
    |> min(50)
    |> max(0)
  end

  def calculate_expiring_quality(quality, sell_in) do
    case sell_in do
      days when days <= 0 -> 0
      days when days <= 5 -> quality + 3
      days when days <= 10 -> quality + 2
      _ -> quality + 1
    end
    |> min(50)
  end
end
