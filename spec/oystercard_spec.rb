require 'oystercard'

describe Oystercard do
  let(:entry_double) { double("entry_double", name: "algate") }
  let(:exit_double) { double("exit_double", name: "poo") }

  context '#attributes variables' do
    it "has balance" do
      expect(subject.balance).to(be(0.00))
    end

    it "has entry_station" do
      subject.instance_variable_defined?(:@entry_station)
    end

    it "has journey history" do
      subject.instance_variable_defined?(:@journeys)
    end

    it "changes the balance variable" do
      expect { subject.top_up(50.00) }.to(change(subject, :balance))
    end
  end

  describe "#top_up" do
    it { is_expected.to(respond_to(:top_up).with(1).argument) }
    it "adds value to balance" do
      subject.top_up(80.00)
      expect(subject.balance).to(eq(80.00))
    end

    it "raises an error if top up brings balance over £90" do
      expect { subject.top_up(95.00) }.to(raise_error(@max_limit_error))
    end
  end

  describe "#deduct" do
    before (:each) do
      subject.top_up(10.00)
    end

    it "reduces balance by a given amount; 'fare'" do
      subject.send(:deduct, 5.50)
      # subject.deduct(5.50)
      expect(subject.balance).to(eq(4.50))
    end
  end

  describe "#in_journey?" do
    it "returns 'false' or 'true' depending on current card status" do
      # assume default status is 'false'??
      expect(subject).not_to(be_in_journey)
    end
  end

  describe "#touch_in" do
    before(:each) do
      subject.instance_variable_set(:@balance, 5.00)
    end

    it "can touch-in" do
      subject.touch_in(entry_double)
      expect(subject).to(be_in_journey)
    end

    it "raises an error if card has less than one pound at touch in" do
      subject.instance_variable_set(:@balance, 0.50)
      expect { subject.touch_in }.to(raise_error(@min_limit_error))
    end

    it "updates the entry station" do
      subject.touch_in(entry_double)
      expect(subject.instance_variable_get(:@entry_station).name).to(eq("algate"))
      # expect(subject.entry_station.name).to eq "algate"
    end
  end

  describe "#touch_out" do
    before(:each) do
      subject.instance_variable_set(:@balance, 5.00)
    end

    it "allows to touch out" do
      subject.touch_in(entry_double)
      subject.touch_out(exit_double)
      expect(subject).not_to(be_in_journey)
    end

    it "accepts exit station" do
      expect(subject).to(respond_to(:touch_out).with(1).argument)
    end

    it "reduces balance by 1.00" do
      expect { subject.touch_out(exit_double) }.to(change { subject.balance }.by(-1.00))
    end

    it "adds journey hash to journeys" do
      expect { subject.touch_out(exit_double) }.to(change { subject.journeys.length }.by(1))
    end

    it "changes entry_station to nil" do
      subject.touch_in(entry_double)
      expect { subject.touch_out(exit_double) }.to(change { subject.entry_station }.to(nil))
    end
  end
end
