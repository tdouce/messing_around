require_relative 'largest_product_diagonals'

describe GridConverter do
  before do
    @str_grid = 
    <<-eos
    1 1 1 1 1 
    1 1 1 1 1 
    1 1 1 1 1 
    1 1 1 1 1 
    1 1 1 1 1 
    eos
  end

  describe ".to_array" do
    it "should convert string representation of grid into a array that contains 5 arrays" do
      expect(GridConverter.to_array(@str_grid).length).to eq(5)
    end

    it "should be a grid, each nested array should contain 5 elements" do
      GridConverter.to_array(@str_grid).each do |array|
        expect(array.length).to eq(5)
      end
    end
  end
end

describe Grid do
  before do
    str_grid = 
    <<-eos
    1 2 2 2 2  
    1 1 1 1 1 
    1 1 1 1 1 
    1 1 1 1 1 
    1 1 1 1 1 
    eos
    @grid = Grid.new(str_grid)
  end

  context "#determine_greater_product" do
    it "should be able to determine the greatest integer" do
      prev_max = 2
      product = 1
      expect(@grid.determine_greater_product(prev_max, product)).to eq(2)
    end

    it "should be able to determine the greatest integer" do
      prev_max = 1 
      product = 2 
      expect(@grid.determine_greater_product(prev_max, product)).to eq(2)
    end

    it "should return 'prev_max' when 'product' nil" do
      prev_max = 2 
      product = nil
      expect(@grid.determine_greater_product(prev_max, product)).to eq(2)
    end
  end

  context "#greatest_product" do
    it "should return the greatest product of any 4 adjacent grid items in entire grid" do
      expect(@grid.greatest_product).to eq(16)
    end
  end
end

describe GridItem do
  before do
    str_grid = 
    <<-eos
    1 2 2 2 2  
    1 1 1 1 1 
    1 1 1 1 1 
    1 1 1 1 1 
    1 1 1 1 1 
    eos
    @grid = GridConverter.to_array(str_grid)
  end

  context "#greatest_product" do
    it "should return the greatest product surrounding indicies [0,0]" do
      gi = GridItem.new([0,0], @grid, 4)
      expect(gi.greatest_product).to eq(16)
    end
  end

  context "#all_directions" do
    it "should return adjacent grid items surrounding indicies [0,0] as arrays that have a length of 4" do
      gi = GridItem.new([0,0], @grid, 4)
      expected_result = [[2, 2, 2, 2], [1, 1, 1, 1], [1, 1, 1, 1]]
      expect(gi.all_directions).to eq(expected_result)
    end

    it "should return adjacent grid items surrounding indicies [2,2] as arrays that have a length of 4" do
      gi = GridItem.new([2,2], @grid, 4)
      expect(gi.all_directions).to eq([])
    end
  end

  context "#inside_grid?" do
    it "should be able to determine if an indicies is inside or outside of the grid" do
      gi = GridItem.new([0,0], @grid, 4)
      expect(gi.inside_grid?(-1, -1)).to eq(false)
    end

    it "should be able to determine if an indicies is inside or outside of the grid" do
      gi = GridItem.new([2,2], @grid, 4)
      expect(gi.inside_grid?(1, 1)).to eq(true)
    end
  end
end

