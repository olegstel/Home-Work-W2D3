require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "oleg") }
  let (:cake) { Dessert.new("cake", 200, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(cake.type).to eq("cake")
    end

    it "sets a quantity" do
      expect(cake.quantity).to eq(200)
    end
    it "starts ingredients as an empty array" do
     expect(cake.ingredients).to be_empty
    end
    it "raises an argument error when given a non-integer quantity" do
    expect{ Dessert.new("cake", "200", chef)}.
            to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      cake.add_ingredient("water")
      expect(cake.ingredients).to include("water")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["suger","flour", "egg", "milk"]
      ingredients.each do |ing|
        cake.add_ingredient(ing)
      end
      cake.mix!
      expect(cake.ingredients.count).to eq(ingredients.count)
      diff =[]
      (0..4).each do |i|
        diff << cake.ingredients[i] if cake.ingredients[i].!=  eq(ingredients[i])
        end
      expect(diff.count).to be > 0

    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity"do
      cake.eat(100)
      expect(cake.quantity).to eq(100)
    end

    it "raises an error if the amount is greater than the quantity" do

      expect{cake.eat(300)}.to raise_error(RuntimeError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Oleg the Great Baker")
      expect(cake.serve).to eq("Chef Oleg the Great Baker has made 200 cakes!")
  end
end
  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(cake)
       cake.make_more
    end
  end
end
