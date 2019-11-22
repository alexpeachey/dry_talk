defmodule AltGildedRoseStep4 do
  @aged_brie "Aged Brie"
  @backstage_passes "Backstage passes to a TAFKAL80ETC concert"
  @sulfuras "Sulfuras, Hand of Ragnaros"

  def update(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%{name: @sulfuras} = item), do: item

  def update_item(%{name: @aged_brie} = item) do
    sell_in = item.sell_in - 1

    quality =
      if sell_in < 0 do
        item.quality + 2
      else
        item.quality + 1
      end
      |> min(50)

    %{item | quality: quality, sell_in: sell_in}
  end

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
    sell_in = item.sell_in - 1

    quality =
      if sell_in < 0 do
        item.quality - 2
      else
        item.quality - 1
      end
      |> max(0)

    %{item | quality: quality, sell_in: sell_in}
  end
end
