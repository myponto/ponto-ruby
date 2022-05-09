require "ponto"

class Ponto::Car < Ponto::BaseResource; end
class Ponto::Manufacturer < Ponto::BaseResource; end

RSpec.describe Ponto::BaseResource do
  describe "#relationship_klass" do
    context "when 'data' attribute is present" do
      it "retrieves the resource name from the 'type' attribute if it is present" do
        car = Ponto::Car.new(Fixture.load_json("relationships/data_with_type.json"))

        expect(car).to respond_to(:maker)
        expect { car.maker }.to_not raise_error(NameError)
      end

      it "falls back to the element name otherwise" do
        car = Ponto::Car.new(Fixture.load_json("relationships/data_without_type.json"))

        expect(car).to respond_to(:manufacturer)
      end
    end

    context "when the 'links' attribute is present" do
      it "retrieves the resource name from the 'type' attribute within the 'links' attribute" do
        car = Ponto::Car.new(Fixture.load_json("relationships/meta_with_type.json"))

        expect(car).to respond_to(:makers)
        expect { car.makers }.to_not raise_error(NameError)
      end
    end
  end
end
