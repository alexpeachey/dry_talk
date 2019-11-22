defmodule GildedRoseStep6 do
  @aged_brie "Aged Brie"
  @backstage_passes "Backstage passes to a TAFKAL80ETC concert"
  @sulfuras "Sulfuras, Hand of Ragnaros"

  def update(items) do
    Enum.map(items, &update_item/1)
  end

  def new_update_item(%{name: @aged_brie} = item) do
    do_update(item, 1)
  end

  def new_update_item(%{name: @backstage_passes} = item) do
    quality = calculate_expiring_quality(item.quality, item.sell_in)
    %{item | quality: quality, sell_in: item.sell_in - 1}
  end

  def new_update_item(item) do
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

  def update_item(item) do
    if !Enum.member?([@sulfuras], item.name) do
      new_update_item(item)
    else
      item =
        cond do
          item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
            if item.quality > 0 do
              if item.name != "Sulfuras, Hand of Ragnaros" do
                %{item | quality: item.quality - 1}
              else
                item
              end
            else
              item
            end

          true ->
            cond do
              item.quality < 50 ->
                item = %{item | quality: item.quality + 1}

                cond do
                  item.name == "Backstage passes to a TAFKAL80ETC concert" ->
                    item =
                      cond do
                        item.sell_in < 11 ->
                          cond do
                            item.quality < 50 ->
                              %{item | quality: item.quality + 1}

                            true ->
                              item
                          end

                        true ->
                          item
                      end

                    cond do
                      item.sell_in < 6 ->
                        cond do
                          item.quality < 50 ->
                            %{item | quality: item.quality + 1}

                          true ->
                            item
                        end

                      true ->
                        item
                    end

                  true ->
                    item
                end

              true ->
                item
            end
        end

      item =
        cond do
          item.name != "Sulfuras, Hand of Ragnaros" ->
            %{item | sell_in: item.sell_in - 1}

          true ->
            item
        end

      cond do
        item.sell_in < 0 ->
          cond do
            item.name != "Aged Brie" ->
              cond do
                item.name != "Backstage passes to a TAFKAL80ETC concert" ->
                  cond do
                    item.quality > 0 ->
                      cond do
                        item.name != "Sulfuras, Hand of Ragnaros" ->
                          %{item | quality: item.quality - 1}

                        true ->
                          item
                      end

                    true ->
                      item
                  end

                true ->
                  %{item | quality: item.quality - item.quality}
              end

            true ->
              cond do
                item.quality < 50 ->
                  %{item | quality: item.quality + 1}

                true ->
                  item
              end
          end

        true ->
          item
      end
    end
  end
end
