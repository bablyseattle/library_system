require 'spec_helper'

describe("Patron") do
  let(:patron) {Patron.new({:id => nil, :name => "Suzie", :birthday => "2004-04-20"})}
  it("creates instance of patron with Patron class when given name and birthday") do
    expect(patron.name).to eq ("Suzie")
  end

  describe(".all") do
    it("is empty at first") do
      expect(Patron.all()).to eq([])
    end
  end

  describe("#save") do
    it("saves each patron and details to database") do
      patron.save()
      expect(Patron.all()).to(eq([patron]))
    end
    it "updates a saved patron in the database" do
      patron.save
      patron.name = "Sue"
      patron.save
      expect(Patron.all()).to eq ([patron])
    end
  end

  describe("#==") do
    it("is the same patron if they have the same title, author, and id") do
      patron1 = Patron.new({:name => "Suzie", :birthday => "2004-04-20", :id => nil})
      patron2 = Patron.new({:name => "Suzie", :birthday => "2004-04-20", :id => nil})
      expect(patron1).to(eq(patron2))
    end
  end

  describe '#delete' do
   it 'will delete patron from database' do
     patron.save
     patron.delete
     expect(Patron.all).to eq []
   end
 end

 describe '.find' do
  it 'will find patron from database' do
    patron.save
    expect(Patron.find(patron.id)).to eq ([patron])
  end
  end
end
