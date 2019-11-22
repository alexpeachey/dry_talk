defmodule GildedRoseTest do
  use ExUnit.Case

  @expectations [
    {
      %Item{name: "+5 Dexterity Vest", sell_in: 20, quality: 25},
      %Item{name: "+5 Dexterity Vest", sell_in: 19, quality: 24}
    },
    {
      %Item{name: "+5 Dexterity Vest", sell_in: 20, quality: 0},
      %Item{name: "+5 Dexterity Vest", sell_in: 19, quality: 0}
    },
    {
      %Item{name: "+5 Dexterity Vest", sell_in: 1, quality: 25},
      %Item{name: "+5 Dexterity Vest", sell_in: 0, quality: 24}
    },
    {
      %Item{name: "+5 Dexterity Vest", sell_in: 0, quality: 25},
      %Item{name: "+5 Dexterity Vest", sell_in: -1, quality: 23}
    },
    {
      %Item{name: "+5 Dexterity Vest", sell_in: 0, quality: 1},
      %Item{name: "+5 Dexterity Vest", sell_in: -1, quality: 0}
    },
    {
      %Item{name: "Elixir of the Mongoose", sell_in: 20, quality: 25},
      %Item{name: "Elixir of the Mongoose", sell_in: 19, quality: 24}
    },
    {
      %Item{name: "Elixir of the Mongoose", sell_in: 20, quality: 0},
      %Item{name: "Elixir of the Mongoose", sell_in: 19, quality: 0}
    },
    {
      %Item{name: "Elixir of the Mongoose", sell_in: 1, quality: 25},
      %Item{name: "Elixir of the Mongoose", sell_in: 0, quality: 24}
    },
    {
      %Item{name: "Elixir of the Mongoose", sell_in: 0, quality: 25},
      %Item{name: "Elixir of the Mongoose", sell_in: -1, quality: 23}
    },
    {
      %Item{name: "Elixir of the Mongoose", sell_in: 0, quality: 1},
      %Item{name: "Elixir of the Mongoose", sell_in: -1, quality: 0}
    },
    {
      %Item{name: "Aged Brie", sell_in: 20, quality: 25},
      %Item{name: "Aged Brie", sell_in: 19, quality: 26}
    },
    {
      %Item{name: "Aged Brie", sell_in: 20, quality: 50},
      %Item{name: "Aged Brie", sell_in: 19, quality: 50}
    },
    {
      %Item{name: "Aged Brie", sell_in: 0, quality: 25},
      %Item{name: "Aged Brie", sell_in: -1, quality: 27}
    },
    {
      %Item{name: "Aged Brie", sell_in: 0, quality: 50},
      %Item{name: "Aged Brie", sell_in: -1, quality: 50}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 11, quality: 20},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 21}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 11, quality: 50},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 50}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 20},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 22}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 49},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 50}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 20},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 4, quality: 23}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 48},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 4, quality: 50}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 1, quality: 20},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 23}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 1, quality: 48},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 50}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 5},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -1, quality: 0}
    },
    {
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -1, quality: 5},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -2, quality: 0}
    },
    {
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 20, quality: 50},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 20, quality: 50}
    },
    {
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 10, quality: 25},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 10, quality: 25}
    },
    {
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 20, quality: 80},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 20, quality: 80}
    }
  ]

  test "Expectations are met" do
    @expectations
    |> Enum.each(fn {input, output} -> assert(GildedRose.update([input]) == [output]) end)
  end

  test "Refactoring works" do
    [
      GildedRoseStep1,
      GildedRoseStep2,
      GildedRoseStep3,
      GildedRoseStep4,
      GildedRoseStep5,
      GildedRoseStep6,
      GildedRoseStep7,
      AltGildedRoseStep1,
      AltGildedRoseStep2,
      AltGildedRoseStep3,
      AltGildedRoseStep4,
      AltGildedRoseStep5,
      AltGildedRoseStep6,
      AltGildedRoseStep7,
      AltGildedRoseStep8,
      AltGildedRoseStep9,
      AltGildedRoseOptional
    ]
    |> Enum.each(fn implementation ->
      @expectations
      |> Enum.each(fn {input, output} -> assert(implementation.update([input]) == [output]) end)
    end)
  end
end
