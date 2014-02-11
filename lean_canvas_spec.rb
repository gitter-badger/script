#!/usr/bin/env ruby -w
# lean_canvas_spec.rb
# Description: Interactive prompt that generates a lean_canvas

class LeanCanvas
    question1 = Array.new
    question1[1] = 'Customer Segments:'
    question1[2] = <<-EOF
Customer Segments:
For whom are we creating value?
Who are our most important customers?
  Examples:
    Mass Market
    Niche Market
    Segmented
    Diversified
    Multi-sided Platform
  EOF
  question2 = Array.new
  question2[1] = 'Key Partners:'
  question2[2] = <<-EOF
Key Partners:
Who are our Key Partners?
Who are our key suppliers?
Which Key Resources are we acquairing from partners?
Which Key Activities do partners perform?
  Motivations:
    motivations for partnerships
    Optimization and economy
    Reduction of risk and uncertainty
    Acquisition of particular resources and activities
  EOF
  question3 = Array.new
  question3[1] = 'Customer Relationships:'
  question3[2] = <<-EOF
Customer Relationships:
What type of relationship does each of our
Customer Segments expect us to establish
and maintain with them?
Which ones have we established?
How are they integrated with the rest of our
business model?
How costly are they?
  Examples:
    Personal assistance
    Dedicated Personal Assistance
    Self-Service
    Automated Services
    Communities
    Co-creation
  EOF
  question4 = Array.new
  question4[1] = 'Key Activities:'
  question4[2] = <<-EOF
Key Activities:
What Key Activities do our Value Propositions require?
Our Distribution Channels?
Customer Relationships?
Revenue streams?
  CATERGORIES
    Production
    Problem Solving
    Platform/Network
  EOF
  question5 = Array.new
  question5[1] = 'Channels:'
  question5[2] = <<-EOF
Channels:
Through which Channels do our Customer Segments
want to be reached?
How are we reaching them now?
How are our Channels integrated?
Which ones work best?
Which ones are most cost-efficient?
How are we integrating them with customer routines?
  Channel phases:
    1. Awareness
    How do we raise awareness about our company’s products and services?
    2. Evaluation
    How do we help customers evaluate our organization’s Value Proposition?
    3. Purchase
    How do we allow customers to purchase specific products and services?
    4. Delivery
    How do we deliver a Value Proposition to customers?
    5. After sales
    A
    How do we provide post-purchase customer support?
  EOF
  question6 = Array.new
  question6[1] = 'Key Resources:'
  question6[2] = <<-EOF
Key Resources:
What Key Resources do our Value Propositions require?
Our Distribution Channels? Customer Relationships?
Revenue Streams?
  Types of resources:
    Physical
    Intellectual (brand patents, copyrights, data)
    Human
    Financial
  EOF
  question7 = Array.new
  question7[1] = 'Value Propositions:'
  question7[2] = <<-EOF
Value Propositions:
What value do we deliver to the customer?
Which one of our customer’s problems are we helping to solve?
What bundles of products and services are we
offering to each Customer Segment?
Which customer needs are we satisfying?
  Characteristics:
    Newness
    Performance
    Customization
    “Getting the Job Done”
    Design
    Brand/Status
    Price
    Cost Reduction
    Risk Reduction
    Accessibility
    Convenience/Usability
  EOF
  question8 = Array.new
  question8[1] = 'Cost Structure:'
  question8[2] = <<-EOF
Cost Structure:
What are the most important costs inherent in our business model?
Which Key Resources are most expensive?
Which Key Activities are most expensive?
  Is your business more:
    Cost Driven (leanest cost structure, low price value proposition, maximum automation, extensive outsourcing)
    Value Driven (focused on value creation, premium value proposition)
  Sample characteristics:
    Fixed Costs (salaries, rents, utilities)
    Variable costs
    Economies of scale
    Economies of scope
  EOF
  question9 = Array.new
  question9[1] = 'Revenue Streams:'
  question9[2] = <<-EOF
Revenue Streams:
For what value are our customers really willing to pay?
For what do they currently pay?
How are they currently paying?
How would they prefer to pay?
How much does each Revenue Stream contribute to overall revenues?
  Types:
    Asset sale
    Usage fee
    Subscription Fees
    Lending/Renting/Leasing
    Licensing
    Brokerage fees
    Advertising
  Fixed Pricing:
    List Price
    Product feature dependent
    Customer segment
    dependent
    Volume dependent
  Dynamic Pricing:
    Negotiation (bargaining)
    Yield Management
    Real-time-Market
  EOF

  QUESTIONS_CATEGORIES = [
    question1[1],
    question2[1],
    question3[1],
    question4[1],
    question5[1],
    question6[1],
    question7[1],
    question8[1],
    question9[1]
  ]
  QUESTIONS_ASK = [
    question1[2],
    question2[2],
    question3[2],
    question4[2],
    question5[2],
    question6[2],
    question7[2],
    question8[2],
    question9[2]
  ]

  attr_accessor :answers
  attr_accessor :project

  def initialize
    @answers = Array.new
  end

  def ask
    9.times do |i|
      puts '\n'
      puts QUESTIONS_ASK[i]
      @answers[i] ||= gets.chomp while @project.nil?
    end
  end

  def save
    puts "What are you calling this project?"
    @project ||= gets.chomp while @project.nil?
    File.open(ENV['HOME'] + "/Desktop/" + @project.downcase.gsub(" ",'_') + '.lean_canvas', 'w+') do |file|
      9.times do |i|
        file.puts QUESTIONS_CATEGORIES[i]
        file.puts @answers[i]
        file.puts "\n"
      end
    end
  end
end

## USAGE
# canvas = LeanCanvas.new
# canvas.ask
# canvas.save

describe LeanCanvas do
  describe "#initialize" do
    it "should iterate over all lean canvas questions" do
      canvas = LeanCanvas.new
      canvas.answers[1] = "Video gamers that prefer RTS."
      canvas.ask
      expect(canvas.answers[1]).to eq('Video gamers that prefer RTS.')
    end

    it "should store all answers given" do
      canvas = LeanCanvas.new
      9.times do |i|
        canvas.answers[i] = 'answers' + i.to_s
      end
      canvas.ask
      9.times do |i|
        expect(canvas.answers[i]).to eq('answers' + i.to_s)
      end
    end

    it "should save by project name" do
      canvas = LeanCanvas.new
      9.times do |i|
        canvas.answers[i] = 'answers' + i.to_s
      end
      canvas.ask
      canvas.project = "Advance Wars"
      canvas.save
      expect(File.exist?(ENV['HOME'] + '/Desktop/' + 'advance_wars.lean_canvas')).to be_true
    end
  end
end
